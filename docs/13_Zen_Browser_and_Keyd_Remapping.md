# 13. Zen Browser & Hardware Keyboard Remapping (Keyd)

## 🌐 1. Zen Browser Installation & Profile

**Zen Browser** is a privacy-focused, gecko-based browser built for tranquility and performance.

- **Package Source**: Packaged declaratively in [`/etc/nixos/pkgs/zen-browser`](/etc/nixos/pkgs/zen-browser/default.nix) using binary release `1.21.15b`.
- **Profile Directory**: `~/.zen/profiles/default/`
- **Custom Styling**: Restored `userChrome.css` from [`dotfiles-cachyos/zen`](/home/l41n-pr0t0/dotfiles-cachyos/zen/userChrome.css) for transparent, blurred UI chrome:
  ```css
  :root {
      --toolbar-bgcolor: transparent !important;
      --lwt-accent-color: transparent !important;
  }
  #main-window, #navigator-toolbox, #browser, #appcontent {
      background: transparent !important;
  }
  ```

---

## ⌨️ 2. Keyd Hardware Remapping & Spectacle Integration

Lenovo Legion keyboards emit `KEY_SELECTIVESCREENSHOT` (code 590) on the dedicated screenshot key.

- **Keyd Service**: `services.keyd.enable = true;` in `/etc/nixos/configuration.nix`.
- **Keyd Mapping**: `~/.config/keyd/default.conf`
  ```ini
  [ids]
  *

  [main]
  selectivescreenshot = print
  ```
- **KDE Spectacle Shortcut**: `~/.config/kglobalshortcutsrc` maps `RectangularRegionScreenShot` and `_launch` to `Print` and `Meta+Shift+S`, triggering instantaneous interactive screen snipping.
