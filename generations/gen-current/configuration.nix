# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  kwin-better-blur-dx = pkgs.kdePackages.callPackage ./pkgs/kwin-effects-better-blur-dx/nix/package.nix { };
  darkly = pkgs.kdePackages.callPackage ./pkgs/darkly/nix/package.nix { };
  sddm-nier-automata = pkgs.callPackage ./pkgs/sddm-nier-automata { };
  pipewire-control-center = pkgs.callPackage ./pkgs/pipewire-control-center { };
  plasma-smart-video-wallpaper-reborn = pkgs.callPackage ./pkgs/plasma-smart-video-wallpaper-reborn { };
  lainwired-color-scheme = pkgs.callPackage ./pkgs/lainwired-color-scheme { };
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader Configuration (Limine)
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 3;

  boot.loader.limine = {
    enable = true;
    maxGenerations = 2;
    style = {
      wallpapers = [ /etc/nixos/lain.png ];
      wallpaperStyle = "centered";
      backdrop = "000000";
      interface = {
        resolution = "1920x1080";
        branding = "limine";
        brandingColor = "d9a8ff";
        helpColor = "d9a8ff";
      };
      graphicalTerminal.font.scale = "2x2";
    };
    extraConfig = ''
      hash_mismatch_panic: no
      remember_last_entry: yes
    '';
  };

  # Hook: Automatically generate Cyberpunk Limine menu on every rebuild
  system.activationScripts.limine-cyberpunk-menu = {
    supportsDryActivation = true;
    text = ''
      if [ -x /etc/nixos/limine-sync.sh ]; then
        /etc/nixos/limine-sync.sh || true
      fi
    '';
  };

  # Graphics & NVIDIA Configuration (RTX 4090 Laptop GPU + Intel Raptor Lake-S UHD)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };

  # Audio Firmware
  hardware.enableAllFirmware = true;
  hardware.firmware = with pkgs; [
    sof-firmware
    alsa-firmware
    linux-firmware
  ];

  # Audio Kernel Modules & Power Management
  boot.extraModprobeConfig = ''
    options snd_hda_intel power_save=0
  '';

  # Systemd Service to keep TAS2781 Speaker Smart Amp active on Boot and Resume
  systemd.services.legion-tas2781-speaker-fix = {
    description = "Lenovo Legion Pro 7 TAS2781 Speaker Power & Firmware Initializer";
    wantedBy = [ "multi-user.target" "post-resume.target" ];
    after = [ "sound.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeShellScript "tas2781-fix" ''
        # Wait for TAS2781 sysfs node
        for i in $(seq 1 15); do
          if [ -f /sys/bus/i2c/drivers/tas2781-hda/i2c-TIAS2781:00/power/control ]; then
            echo on > /sys/bus/i2c/drivers/tas2781-hda/i2c-TIAS2781:00/power/control
            break
          fi
          sleep 1
        done

        # Disable HDA power saving
        if [ -f /sys/module/snd_hda_intel/parameters/power_save ]; then
          echo 0 > /sys/module/snd_hda_intel/parameters/power_save
        fi

        # Force TAS2781 speaker firmware reload
        ${pkgs.alsa-utils}/bin/amixer -c PCH cset name='Speaker Force Firmware Load' 1 2>/dev/null || true
        ${pkgs.alsa-utils}/bin/amixer -c PCH set 'Speaker' 100% unmute 2>/dev/null || true
        ${pkgs.alsa-utils}/bin/amixer -c PCH set 'Master' unmute 2>/dev/null || true

        # Lock Internal Mic Boost to 0 dB to eliminate background hiss
        ${pkgs.alsa-utils}/bin/amixer -c PCH set 'Internal Mic Boost' 0% 2>/dev/null || true
        ${pkgs.alsa-utils}/bin/amixer -c PCH set 'Capture' 35% 2>/dev/null || true
      '';
    };
  };

  # Mount Scientia NTFS Partition with Full User Permissions
  fileSystems."/run/media/l41n-pr0t0/Scientia" = {
    device = "/dev/disk/by-uuid/E45C6FF55C6FC0C2";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=1001"
      "gid=100"
      "umask=000"
      "dmask=0000"
      "fmask=0000"
      "iocharset=utf8"
      "nofail"
    ];
  };

  # Keyd configuration
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = [ "*" ];
      settings = {
        main = {
          selectivescreenshot = "print";
        };
      };
    };
  };

  # Enable nix-ld for running dynamically linked binaries
  programs.nix-ld.enable = true;

  # Use stable LTS kernel with full binary driver support
  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "wired_navi0x17";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment with Animated Video SDDM
  services.displayManager.sddm = {
    enable = true;
    theme = "nier-automata";
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qtvirtualkeyboard
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-libav
    ];
  };
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Shells
  programs.fish.enable = true;

  # Define a user account with default Fish shell
  users.users."l41n-pr0t0" = {
    isNormalUser = true;
    description = "l41n-pr0t0";
    initialPassword = "lain";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    packages = with pkgs; [
      kdePackages.kate
      kdePackages.kamoso
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Shell aliases
  programs.bash.shellAliases = {
    agy = "agy";
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile.
  environment.etc."xdg/kdeglobals".source = "${lainwired-color-scheme}/share/color-schemes/LainWired.colors";

  environment.systemPackages = with pkgs; [
    kitty
    vscode
    fish
    fastfetch
    zoxide
    copyq
    wl-clipboard
    xclip
    (papirus-icon-theme.override { color = "violet"; })
    papirus-folders
    catppuccin-cursors.frappePink
    efibootmgr
    kwin-better-blur-dx
    darkly
    sddm-nier-automata
    pipewire-control-center
    plasma-smart-video-wallpaper-reborn
    lainwired-color-scheme
    keyd
    (callPackage ./pkgs/zen-browser {})
    pciutils
    alsa-utils
    pavucontrol
    qpwgraph
    easyeffects
    (pkgs.writeShellScriptBin "agy" ''
      exec /nix/store/3484728gx1qndq06y09qxgq9sr02n1ms-antigravity-cli-1.1.21/bin/agy "$@"
    '')
  ];

  # Default editor environment variables
  environment.sessionVariables = {
    EDITOR = "code --wait";
    VISUAL = "code --wait";
  };

  system.stateVersion = "26.05";
}
