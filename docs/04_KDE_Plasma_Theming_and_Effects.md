# 04. KDE Plasma Theming, SDDM Animated Greeter & Instant Theme Loading

## 🖥️ 1. Animated Video SDDM Display Manager
The display manager is styled with the **NieR:Automata YoRHa OS Animated Video Greeter** (`nier-automata`).

- **Active SDDM Theme**: `nier-automata` ([`/etc/nixos/pkgs/sddm-nier-automata`](/etc/nixos/pkgs/sddm-nier-automata/default.nix))
- **Video Background**: `Untitled design.mp4` (`/home/l41n-pr0t0/Videos/Untitled design.mp4` copied to `bg.mp4`)
- **Architecture**: Qt6 QML + `QtMultimedia` + GStreamer hardware codecs (Libav, Base, Good).
- **Features**:
  - Full-screen looping video background (`bg.mp4`)
  - Rotating YoRHa crest with dual-ring clock & data sync diagnostics
  - Custom themed YoRHa buttons and session management
  - Wayland layer-shell integration

---

## ⚡ 2. Instant Native Theme Loading (0ms Delay on Login)

All theme configurations are baked directly into Plasma's static configuration files and the system-wide Nix store:

- **System-Wide Color Scheme**: `LainWired.colors` in `/run/current-system/sw/share/color-schemes/LainWired.colors`.
- **Static Settings**:
  - `~/.config/kdeglobals`: `ColorScheme=LainWired`, `AccentColor=170,85,255`, `Theme=Papirus`.
  - `~/.config/kcminputrc`: `cursorTheme=catppuccin-frappe-pink-cursors`.
  - `~/.config/plasma-org.kde.plasma.desktop-appletsrc`: `Image=file:///home/l41n-pr0t0/Pictures/Lain/bbb8b0b422412104036c7075a9651381-upscaled-2x.png`.
- **No Autostart Script Lag**: Removed runtime reload scripts so Plasma loads the entire theme natively on frame 1 without delay or screen redrawing.

---

## 🎨 3. Plasma 6 Window Decorations & Qt Styles
- **Application Style**: **Darkly Qt6** (`darkly` / `darkly-settings6`)
- **KWin Effects**: **Better Blur DX** (`kwin-effects-better-blur-dx`) with background force-blur
- **Icon Theme**: **Papirus-Dark** with violet folder accents
- **Cursor Theme**: **Catppuccin Frappé Pink** (`catppuccin-cursors.frappePink`)
- **Lock Screen**: **Smart Video Wallpaper Reborn** (`io.github.luisbocanegra.smartvideowallpaper`) with `Untitled design.mp4`
