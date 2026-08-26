# 08. Default Applications & MIME Handlers

## 🎯 Overview
In this NixOS setup, default file associations, clipboard monitors, web protocols, and terminal handlers are configured across the XDG standard (`~/.config/mimeapps.list`), KDE Plasma 6 service databases, and NixOS environment variables.

---

## 📋 System Default Applications Summary

| Category | Default Application | Desktop Entry | Handled MIME Types / Protocols |
| :--- | :--- | :--- | :--- |
| **Clipboard Manager** | **CopyQ** | `copyq.desktop` | System-wide daemon & tray (`autostart`) |
| **Wayland Clipboard** | **wl-clipboard** | CLI (`wl-copy` / `wl-paste`) | Primary Wayland clipboard interface |
| **X11 Clipboard** | **xclip** | CLI (`xclip -sel clip`) | XWayland / X11 fallback |
| **Code & Markdown** | **Visual Studio Code** | `code.desktop` | `text/markdown`, `text/x-markdown`, `text/plain` |
| **Default Terminal** | **Kitty** | `kitty.desktop` | Interactive GPU terminal emulator |
| **Default Login Shell**| **Fish** | `/run/current-system/sw/bin/fish` | Native default shell for user `l41n-pr0t0` |
| **Web Browser** | **Firefox** | `firefox.desktop` | `http`, `https`, `text/html`, `about` |
| **File Manager** | **Dolphin** | `org.kde.dolphin.desktop`| `inode/directory` + "Open with Code" action |
| **PDF Viewer** | **Okular** | `org.kde.okular.desktop` | `application/pdf` |
| **AI Coding Assistant**| **Antigravity CLI** | `agy` wrapper | Interactive pair programmer CLI |
| **AI Terminal Agent** | **OpenCode** | `opencode` | TUI coding agent |

---

## 🔧 Active `~/.config/mimeapps.list`

```ini
[Default Applications]
text/markdown=code.desktop;
text/x-markdown=code.desktop;
text/plain=code.desktop;
inode/directory=org.kde.dolphin.desktop;
text/html=firefox.desktop;
x-scheme-handler/http=firefox.desktop;
x-scheme-handler/https=firefox.desktop;
x-scheme-handler/about=firefox.desktop;
x-scheme-handler/unknown=firefox.desktop;
application/pdf=org.kde.okular.desktop;

[Added Associations]
text/markdown=code.desktop;
text/x-markdown=code.desktop;
text/plain=code.desktop;
inode/directory=org.kde.dolphin.desktop;
text/html=firefox.desktop;
x-scheme-handler/http=firefox.desktop;
x-scheme-handler/https=firefox.desktop;
application/pdf=org.kde.okular.desktop;
```

---

## 🛠️ CLI Query & Update Cheat Sheet

### Check default application for a MIME type:
```bash
xdg-mime query default text/markdown
xdg-mime query default text/plain
xdg-mime query default x-scheme-handler/https
```

### Set a default application:
```bash
xdg-mime default code.desktop text/markdown
xdg-mime default firefox.desktop x-scheme-handler/https
kbuildsycoca6
```
