# 03. Keyd Hardware Daemon & KDE Plasma Shortcuts

## ⌨️ 1. Hardware Keyd Daemon
The low-level hardware daemon [`keyd`](https://github.com/rvaiya/keyd) intercepts keystrokes at the kernel input event layer.

- **Service Definition**: `services.keyd` in `/etc/nixos/configuration.nix`
- **Mapping**: `selectivescreenshot = "print"` (maps the physical Lenovo snipping key directly to standard `PrintScreen` for Spectacle).

---

## ⚡ 2. KDE Plasma 6 Global Shortcuts (`~/.config/kglobalshortcutsrc`)

### 🔍 Conflict Resolution:
Legacy CachyOS tiling shortcuts (such as `KrohnkiteFocusRight=Meta+L`) were intercepting and swallowing the `Meta + L` keystroke before it reached session management. All conflicting tiling bindings were cleared, ensuring clean direct dispatch to `ksmserver`.

| Shortcut | Action | Component | Description |
| :--- | :--- | :--- | :--- |
| **`Meta + L`** | **Lock Session** | `ksmserver` | Instantly locks the session and loads the animated video lockscreen (`Untitled design.mp4`) |
| **`Meta + W`** | **Overview Grid** | `kwin` | Standard KDE window overview grid |
| **`Alt + F4`** | **Close Window** | `kwin` | Closes active application window |
| **`Print`** | **Rectangular Snipping** | `spectacle` | Opens Spectacle region screenshot |
