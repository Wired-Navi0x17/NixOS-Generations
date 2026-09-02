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

## ⌨️ 2. Hardware Keyboard Remapping & Spectacle Integration

Lenovo Legion keyboards emit `KEY_SELECTIVESCREENSHOT` (code 634 / `0x27a`) on the dedicated screenshot key via ACPI device `/dev/input/event8` (`Ideapad extra buttons`).

### 🛠️ Hardware-Level Remapping via udev hwdb
Because `keyd` only supports keycodes up to 255 and rejects keycode 634 (`selectivescreenshot`), the key is remapped directly at the Linux kernel driver layer in `/etc/nixos/configuration.nix`:

```nix
services.udev.extraHwdb = ''
  evdev:name:Ideapad extra buttons:dmi:bvn*:bvr*:bd*:svnLENOVO*:pn*:*
   KEYBOARD_KEY_46=print

  evdev:name:ThinkPad Extra Buttons:dmi:bvn*:bvr*:bd*:svnLENOVO*:pn*:*
   KEYBOARD_KEY_46=print

  evdev:atkbd:dmi:bvn*:bvr*:bd*:svnLENOVO*:pn*:*
   KEYBOARD_KEY_46=print
   KEYBOARD_KEY_b7=print
'';
```
- **Driver**: `ideapad_laptop` intercepts hardware scancode `46` and translates it into `KEY_PRINT`.

### 🎯 KDE Spectacle Shortcut Integration
In `~/.config/kglobalshortcutsrc` and live KWin memory, `RectangularRegionScreenShot` is registered to trigger on both `Print`, `Launch (7)`, and `Meta+Shift+S`:

```ini
[org.kde.spectacle.desktop]
RectangularRegionScreenShot=Print\tLaunch (7)\tMeta+Shift+S,Print\tLaunch (7)\tMeta+Shift+S,Capture Rectangular Region
_launch=none,none,Launch Spectacle
```

- When the physical scissor/snipping button is pressed, KDE Spectacle launches interactive rectangular screen snipping immediately.

