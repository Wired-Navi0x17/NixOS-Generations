# 02. Limine Bootloader & Cyberpunk Dual-Boot

## 🚀 1. Overview
The bootloader is powered by **Limine** in raw UEFI graphical mode (`boot.loader.limine.enable = true;`).

- **Theme & Branding**:
  - Centered Lain wallpaper (`/etc/nixos/lain.png`)
  - `#d9a8ff` accent branding and help text
  - `interface_branding: wired://boot` in top right header
  - Crisp `2x2` terminal font scaling
  - 1:1 match with CachyOS Limine layout

---

## 📋 2. CachyOS-Styled Dynamic Entry Hierarchy

Synchronized automatically upon every `nixos-rebuild switch` via `/etc/nixos/limine-sync.sh`:

```limine
/+NixOS
  comment: NixOS Workstation
  //linux-nixos
    comment: Kernel version: 6.18.46
    protocol: linux
    kernel_path: boot():/limine/kernels/gen-17-bzImage
    cmdline: init=/nix/store/.../init root=fstab loglevel=4 lsm=landlock,yama,bpf
    module_path: boot():/limine/kernels/gen-17-initrd

  //linux-nixos-safe
    comment: Kernel version: 6.18.46 (Generation 16)
    protocol: linux
    kernel_path: boot():/limine/kernels/gen-16-bzImage
    cmdline: init=/nix/store/.../init root=fstab loglevel=4 lsm=landlock,yama,bpf
    module_path: boot():/limine/kernels/gen-16-initrd

//Snapshots
  comment: NixOS Generation Archive
  ///Generation 15
    protocol: linux
    ...
  ///Generation 14
    protocol: linux
    ...

/Windows Boot Manager
  comment: Microsoft Windows Boot Manager
  protocol: efi
  path: uuid(e63c118c-207f-47b9-b045-b4f3bec8d8ca):/EFI/Microsoft/Boot/bootmgfw.efi

/EFI fallback
  comment: Default UEFI Fallback Loader
  protocol: efi
  path: boot():/EFI/boot/bootx64.efi
```
