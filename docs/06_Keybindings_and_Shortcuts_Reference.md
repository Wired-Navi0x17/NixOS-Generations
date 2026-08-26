# 06. Keybindings, Navigation & Window Management Reference

## 🚀 1. Essential Desktop & Window Shortcuts

| Keystroke | Action | Component |
| :--- | :--- | :--- |
| <kbd>Meta</kbd> + <kbd>D</kbd> | **Show / Peek at Desktop** | KWin Window Manager |
| <kbd>Meta</kbd> + <kbd>W</kbd> | **Toggle Overview (All Windows & Desktops)** | KWin Overview |
| <kbd>Meta</kbd> + <kbd>L</kbd> | **Lock Screen** | KSMServer / Screen Locker |
| <kbd>Meta</kbd> + <kbd>Q</kbd> / <kbd>Alt</kbd> + <kbd>F4</kbd> | **Close Active Window** | KWin Window Manager |
| <kbd>Meta</kbd> + <kbd>↑</kbd> | **Maximize Window** | KWin Window Manager |
| <kbd>Meta</kbd> + <kbd>↓</kbd> | **Minimize / Restore Window** | KWin Window Manager |
| <kbd>Meta</kbd> + <kbd>←</kbd> | **Quick Tile Window Left** | KWin Window Manager |
| <kbd>Meta</kbd> + <kbd>→</kbd> | **Quick Tile Window Right** | KWin Window Manager |
| <kbd>Alt</kbd> + <kbd>Tab</kbd> | **Walk Through Windows** | KWin Task Switcher |
| <kbd>PrtSc</kbd> / <kbd>Meta</kbd> + <kbd>Shift</kbd> + <kbd>S</kbd> | **Interactive Rectangular Screen Snip** | Keyd + Spectacle |
| <kbd>Meta</kbd> | **Open Application Launcher** | Plasma Shell |

---

## 🛠️ 2. Configuration & Conflict Resolution
- **Config File**: `~/.config/kglobalshortcutsrc`
- **Krohnkite Conflicts**: Automatically cleared to prevent tiling shortcut hijacking.
- **Reload Command**:
  ```bash
  qdbus org.kde.KGlobalAccel /KGlobalAccel org.kde.KGlobalAccel.reloadConfig
  ```
