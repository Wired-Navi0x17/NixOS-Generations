# 🌐 Lain Wired NixOS Workstation Documentation

Welcome to the complete technical documentation for the **Lain Wired NixOS** workstation environment. This documentation details every system configuration, package, theme component, bootloader parameter, and backup restoration performed on this machine.

---

## 📑 Documentation Index

1. **[01. System Architecture & NixOS Declarative Setup](01_System_Architecture_and_NixOS.md)**
   - System configuration file (`/etc/nixos/configuration.nix`)
   - Default login shell (`users.users."l41n-pr0t0".shell = pkgs.fish;`)
   - Linux LTS kernel with binary cache drivers
   - Networking, audio (`pipewire`), display manager (`sddm` + `plasma6`)
   - `nix-ld` integration for unpatched generic Linux binaries
   - Custom package derivations (`kwin-better-blur-dx`, `darkly-qt6`, `agy`)

2. **[02. Limine Bootloader & Cyberpunk Dual-Boot](02_Limine_Bootloader_and_DualBoot.md)**
   - Cyberpunk dynamic boot menu layout (`01 ONLINE`, `02 STANDBY`, `03 EXTERNAL`, `04 MATRIX INDEX`)
   - Automated rebuild hook (`limine-sync.sh`) tracking active NixOS generations
   - Lain centered wallpaper (`/etc/nixos/lain.png`) and `#d9a8ff` purple branding
   - Windows Boot Manager UEFI chainloading (`PARTUUID: e63c118c-207f-47b9-b045-b4f3bec8d8ca`)

3. **[03. Keyd Hardware Daemon & Key Remapping](03_Keyd_Hardware_Remapping.md)**
   - `services.keyd` declarative daemon setup
   - Hardware-level `selectivescreenshot = print` mapping
   - Systemd service lifecycle and configuration syntax

4. **[04. KDE Plasma Theming, SDDM Animated Greeter & Lock Screen](04_KDE_Plasma_Theming_and_Effects.md)**
   - **SDDM Animated Video Greeter**: NieR:Automata YoRHa OS with `Untitled design.mp4`
   - **KDE Plasma 6 Lock Screen**: Smart Video Wallpaper engine with `Untitled design.mp4`
   - **Dolphin Context Menu**: "Open with Code" service menu (`open-in-code.desktop`)
   - **Papirus Violet Folders**: Purple folder styling across Dolphin and Plasma 6
   - **Darkly Style & Better Blur DX**: Qt6 application style & KWin background blur effect

5. **[05. Terminal Ricing: Kitty, Fish Shell & Fastfetch](05_Kitty_Fish_Fastfetch_Rice.md)**
   - **Kitty Terminal**: 100% repo sync, `0.70` background opacity, `128` blur, `#c084fc` borders, Lain image gallery
   - **Fish Shell**: Minimalist CachyOS-style `> ` prompt symbol, right-hand path & git indicator
   - **Fastfetch**: Dynamic random Lain avatar rotator (`random_lain.sh`) invoked via `fish_greeting`

6. **[06. Development Editors, AI Tools & Clipboard](06_Development_Editors_and_AI_Tools.md)**
   - **Clipboard Stack**: `CopyQ` clipboard manager, `wl-clipboard` (Wayland), `xclip` (X11)
   - **Antigravity CLI (`agy`)**: System wrapper and user shell alias integration
   - **OpenCode AI**: Terminal-first AI agent CLI/TUI (`opencode`), binary patching, and usage
   - **VS Code**: Single-window tab reuse (`"window.openFilesInNewWindow": "off"`), snippets, Lunar Pink theme

7. **[07. CachyOS Backup Migration & Inventory](07_Backup_Migration_Inventory.md)**
   - Itemized audit of all restored configuration files from CachyOS backup
   - Restored paths for SSH keys, Obsidian skills, personal scripts, SDDM themes, and software lists

8. **[08. Default Applications & MIME Handlers](08_Default_Applications_and_MIME_Handlers.md)**
   - Complete mapping of default system applications and MIME handlers

9. **[09. Hardware Graphics, NVIDIA Drivers & Peripherals](09_Hardware_Graphics_NVIDIA_and_Peripherals.md)**
   - NVIDIA GeForce RTX 4090 Laptop GPU + Intel Raptor Lake-S UHD Graphics
   - NVIDIA PRIME Offload (`nvidia-offload`), `nvidia-settings`, modesetting
   - Kamoso native KDE camera and webcam recording application
   - Declarative `Scientia` NTFS drive mount with permanent read/write/cut permissions

10. **[10. Storage Maintenance & Diagnostics](10_Storage_Maintenance_and_Diagnostics.md)**
    - Partition health, sizes, and utilization overview (Reclaimed 840MB on `/boot`)
    - Nix store garbage collection & hardlink deduplication

11. **[11. Legion Pro 7 Audio & Microphone Architecture](11_Legion_Pro7_Audio_and_Microphone.md)**
    - Realtek ALC287 + Texas Instruments TAS2781 smart amplifier setup
    - TAS2781 persistence daemon, power-saving fixes, and speaker firmware initialization

12. **[12. PipeWire Controller & Studio-Grade Microphone Pipeline](12_PipeWire_Controller_and_Studio_Microphone.md)**
    - PipeWire Controller GUI (`pipewire-control-center` / `pwcc`)
    - 5-Pillar absolute-quality microphone setup (0dB boost lock, WirePlumber AGC block, High-Pass 80Hz filter, RNNoise AI suppression, vocal clarity EQ, compressor, peak limiter)

---

## ⚡ Quick Reference Commands

| Task | Command |
| :--- | :--- |
| **Launch PipeWire Controller** | `pwcc` or `pipewire-control-center` |
| **Launch Audio Effects** | `easyeffects` |
| **Launch Audio Routing** | `qpwgraph` |
| **Volume Control** | `pavucontrol` |
| **Rebuild System** | `sudo nixos-rebuild switch` |
| **Run App on RTX 4090** | `nvidia-offload <app_name>` |
| **Launch Antigravity** | `agy` |
| **Launch OpenCode** | `opencode` |
| **Launch Kamoso Camera** | `kamoso` |
| **Launch CopyQ Manager** | `copyq toggle` |
| **Clean Nix Store (Free Disk)** | `sudo nix-collect-garbage --delete-older-than 7d` |
| **Check Bootloader Entries** | `sudo cat /boot/limine/limine.conf` |
