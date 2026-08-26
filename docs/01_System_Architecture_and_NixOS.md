# 01. System Architecture & NixOS Declarative Setup

## 🏗️ Overview
NixOS is a purely functional Linux distribution where the entire operating system configuration, installed packages, kernel parameters, user default login shells, system services, and bootloader options are declared inside reproducible Nix files.

The primary system configuration file is located at:
`/etc/nixos/configuration.nix`

---

## 📦 Installed Packages

The following packages are installed declaratively in `environment.systemPackages`:

| Package Name | Purpose |
| :--- | :--- |
| `pkgs.kitty` | GPU-accelerated terminal emulator with transparency, blur & icat graphics protocol |
| `pkgs.vscode` | Visual Studio Code editor |
| `pkgs.fish` | Interactive smart shell (configured as native user login shell) |
| `pkgs.fastfetch` | Fast system information display tool with dynamic Lain avatar rotation |
| `pkgs.zoxide` | Smarter `cd` directory navigator |
| `pkgs.copyq` | Advanced clipboard manager daemon with history and GUI |
| `pkgs.wl-clipboard` | Primary Wayland command-line clipboard utility (`wl-copy`, `wl-paste`) |
| `pkgs.xclip` | X11 / XWayland clipboard compatibility utility |
| `pkgs.papirus-icon-theme` | Clean SVG icon theme (overridden with `color = "violet"`) |
| `pkgs.papirus-folders` | Script for modifying Papirus folder accent colors |
| `pkgs.catppuccin-cursors.frappePink` | Soft pastel pink mouse cursor theme |
| `pkgs.efibootmgr` | UEFI NVRAM boot manager manipulation utility |
| `pkgs.kdePackages.kate` | Advanced text editor for KDE |
| `kwin-better-blur-dx` | Custom KWin 6 blur effect plugin compiled from source |
| `darkly` | Custom Qt 6 / KDE Plasma 6 widget style and window decoration |
| `agy` wrapper | Shell executable wrapper for Google Antigravity CLI |

---

## ⚙️ Core System Services

### 1. Default Shell (`users.users."l41n-pr0t0".shell = pkgs.fish;`)
- Configured Fish as the system-wide native login shell.

### 2. Keyd Daemon (`services.keyd`)
- Hardware-level key interceptor and mapper.
- Remaps `selectivescreenshot` key to `print`.

### 3. Audio Stack (`services.pipewire`)
- High-performance, low-latency audio server.
- Enabled with ALSA 32-bit/64-bit support and PulseAudio emulation layer.
- `security.rtkit.enable = true;` enables real-time scheduling priority for audio threads.

### 4. Display & Desktop (`services.desktopManager.plasma6`)
- Display Manager: SDDM (`services.displayManager.sddm.enable = true;`)
- Desktop Environment: KDE Plasma 6 Wayland session with X11 backwards compatibility.

### 5. Dynamic Linker Loader (`programs.nix-ld`)
- Enabled via `programs.nix-ld.enable = true;`.
- Allows running generic, pre-compiled dynamically linked Linux binaries (such as `opencode`, language server binaries, and VS Code extensions) out of the box on NixOS without manual patching.

---

## 🛠️ Complete `/etc/nixos/configuration.nix` File

```nix
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  kwin-better-blur-dx = pkgs.kdePackages.callPackage ./pkgs/kwin-effects-better-blur-dx/nix/package.nix { };
  darkly = pkgs.kdePackages.callPackage ./pkgs/darkly/nix/package.nix { };
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
    maxGenerations = 10;
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
    extraEntries = ''
      /Windows Boot Manager
        protocol: efi
        path: uuid(e63c118c-207f-47b9-b045-b4f3bec8d8ca):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
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

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
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
```
