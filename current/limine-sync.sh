#!/bin/sh
set -e

WALLPAPER=$(find /boot/limine/wallpapers -name "*lain.png*" 2>/dev/null | head -n 1 || echo "")
if [ -n "$WALLPAPER" ]; then
  WALLPAPER_LINE="wallpaper: boot():${WALLPAPER#/boot}"
else
  WALLPAPER_LINE=""
fi

# Keep only the latest 3 generations to prevent /boot exhaustion
PROFILES=$(ls -d -1 -v /nix/var/nix/profiles/system-*-link 2>/dev/null | tail -n 3 || true)
TOTAL=$(echo "$PROFILES" | grep -c "system-" || echo "0")

if [ "$TOTAL" -ge 1 ]; then
  CUR_PROFILE=$(echo "$PROFILES" | tail -n 1)
  CUR_NUM=$(echo "$CUR_PROFILE" | grep -o '[0-9]\+')
else
  CUR_PROFILE="/nix/var/nix/profiles/system"
  CUR_NUM="1"
fi

if [ "$TOTAL" -ge 2 ]; then
  PREV_PROFILE=$(echo "$PROFILES" | tail -n 2 | head -n 1)
  PREV_NUM=$(echo "$PREV_PROFILE" | grep -o '[0-9]\+')
else
  PREV_PROFILE="$CUR_PROFILE"
  PREV_NUM="$CUR_NUM"
fi

mkdir -p /boot/limine/kernels

copy_kernel() {
  prof="$1"
  pnum="$2"
  k=$(readlink -f "$prof/kernel")
  i=$(readlink -f "$prof/initrd")
  init=$(readlink -f "$prof/init")
  params=$(cat "$prof/kernel-params" 2>/dev/null || echo "root=fstab loglevel=4")
  
  k_dest="/boot/limine/kernels/gen-${pnum}-bzImage"
  i_dest="/boot/limine/kernels/gen-${pnum}-initrd"
  
  if [ ! -f "$k_dest" ]; then
    cp "$k" "$k_dest"
  fi
  if [ ! -f "$i_dest" ]; then
    cp "$i" "$i_dest"
  fi
  
  echo "boot():/limine/kernels/gen-${pnum}-bzImage|boot():/limine/kernels/gen-${pnum}-initrd|init=$init $params"
}

CUR_DATA=$(copy_kernel "$CUR_PROFILE" "$CUR_NUM")
CUR_K=$(echo "$CUR_DATA" | cut -d'|' -f1)
CUR_I=$(echo "$CUR_DATA" | cut -d'|' -f2)
CUR_CMD=$(echo "$CUR_DATA" | cut -d'|' -f3)

PREV_DATA=$(copy_kernel "$PREV_PROFILE" "$PREV_NUM")
PREV_K=$(echo "$PREV_DATA" | cut -d'|' -f1)
PREV_I=$(echo "$PREV_DATA" | cut -d'|' -f2)
PREV_CMD=$(echo "$PREV_DATA" | cut -d'|' -f3)

KERNEL_VER=$(uname -r)

cat << LIMINECONF > /boot/limine/limine.conf
timeout: 3
editor_enabled: no
hash_mismatch_panic: no
graphics: yes
default_entry: 1
$WALLPAPER_LINE
wallpaper_style: centered
backdrop: 000000
interface_resolution: 1920x1080
interface_branding: wired://boot
interface_branding_colour: d9a8ff
interface_help_colour: d9a8ff
interface_help_hidden: no
term_font_scale: 2x2

/+NixOS
  comment: NixOS Workstation
  //linux-nixos
    comment: Kernel version: $KERNEL_VER
    protocol: linux
    kernel_path: $CUR_K
    cmdline: $CUR_CMD
    module_path: $CUR_I

  //linux-nixos-safe
    comment: Kernel version: $KERNEL_VER (Generation $PREV_NUM)
    protocol: linux
    kernel_path: $PREV_K
    cmdline: $PREV_CMD
    module_path: $PREV_I
LIMINECONF

ACTIVE_KERNELS="gen-${CUR_NUM}-bzImage gen-${CUR_NUM}-initrd gen-${PREV_NUM}-bzImage gen-${PREV_NUM}-initrd"

if [ "$TOTAL" -gt 2 ]; then
  OLDER_PROFS=$(echo "$PROFILES" | head -n -2 | tac || true)
  cat << LIMINESNAP >> /boot/limine/limine.conf

//Snapshots
  comment: NixOS Generation Archive
LIMINESNAP
  for arch in $OLDER_PROFS; do
    [ -n "$arch" ] || continue
    arch_num=$(echo "$arch" | grep -o '[0-9]\+')
    arch_data=$(copy_kernel "$arch" "$arch_num")
    arch_k=$(echo "$arch_data" | cut -d'|' -f1)
    arch_i=$(echo "$arch_data" | cut -d'|' -f2)
    arch_cmd=$(echo "$arch_data" | cut -d'|' -f3)
    ACTIVE_KERNELS="$ACTIVE_KERNELS gen-${arch_num}-bzImage gen-${arch_num}-initrd"
    cat << LIMINEARCH >> /boot/limine/limine.conf
  ///Generation $arch_num
    comment: Generation $arch_num Archive
    protocol: linux
    kernel_path: $arch_k
    cmdline: $arch_cmd
    module_path: $arch_i
LIMINEARCH
  done
fi

cat << LIMINEFOOTER >> /boot/limine/limine.conf

/Windows Boot Manager
  comment: Microsoft Windows Boot Manager
  protocol: efi
  path: uuid(e63c118c-207f-47b9-b045-b4f3bec8d8ca):/EFI/Microsoft/Boot/bootmgfw.efi

/EFI fallback
  comment: Default UEFI Fallback Loader
  protocol: efi
  path: boot():/EFI/boot/bootx64.efi
LIMINEFOOTER

# Prune old orphaned kernels from /boot/limine/kernels
for f in /boot/limine/kernels/*; do
  [ -f "$f" ] || continue
  bname=$(basename "$f")
  case " $ACTIVE_KERNELS " in
    *" $bname "*)
      ;;
    *)
      echo "Pruning old kernel file from /boot: $bname"
      rm -f "$f"
      ;;
  esac
done

echo "Limine sync completed. Boot partition pruned and optimized."
