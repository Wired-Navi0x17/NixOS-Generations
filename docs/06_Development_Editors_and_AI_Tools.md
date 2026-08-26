# 06. Development Editors, AI Tools & Clipboard

## 📋 1. Clipboard Management Stack
- **CopyQ**: Advanced clipboard manager with searchable history and persistent storage (`pkgs.copyq`).
  - Autostart enabled via `~/.config/autostart/copyq.desktop`.
  - Toggle UI: Run `copyq toggle` or click tray icon.
- **Wayland Native Clipboard**: `wl-clipboard` (`wl-copy` and `wl-paste`).
- **X11 / XWayland Fallback**: `xclip` (`xclip -selection clipboard`).

---

## 🤖 2. Google Antigravity CLI (`agy`)
- **Binary**: `/nix/store/3484728gx1qndq06y09qxgq9sr02n1ms-antigravity-cli-1.1.21/bin/agy`
- **System Wrapper**: `/run/current-system/sw/bin/agy`
- **User Symlink**: `~/.local/bin/agy`
- **Shell Aliases**:
  - Bash: `alias agy='agy'` in `/etc/nixos/configuration.nix` & `~/.bashrc`
  - Fish: `alias agy='...'` in `~/.config/fish/config.fish`
- **Usage**: Type `agy` in any terminal to launch the interactive Antigravity coding assistant.

---

## 🧠 3. OpenCode AI Agent CLI / TUI
- **Binary**: `~/.opencode/bin/opencode`
- **Symlink**: `~/.local/bin/opencode`
- **Version**: `1.18.23`
- **Dynamic Linking**: Supported natively via `programs.nix-ld.enable = true;` and patched ELF interpreter.
- **Usage**:
  ```bash
  cd /path/to/project
  opencode
  ```
- **Features**:
  - Terminal User Interface (TUI) for multi-file codebase search, refactoring, and execution.
  - Multi-model support (Claude, GPT-4, Gemini, Ollama local models).
  - Non-interactive scripting mode for automated pipelines.

---

## 💻 4. Visual Studio Code (`vscode`)
- **Package**: `pkgs.vscode` (`/run/current-system/sw/bin/code`)
- **Configuration**: `~/.config/Code/User/settings.json`
- **Window Tab Reuse**:
  - Configured with `"window.openFilesInNewWindow": "off"` and `"window.openFoldersInNewWindow": "off"`.
  - Opening Markdown documents, files, or folders from Dolphin / `agy` reuses the active window as a new tab instead of spawning a new window each time.
- **Desktop Entry**: `~/.local/share/applications/code.desktop` with `Exec=code -r %F`.
- **Theme Customization**: Custom **Lunar Pink** palette:
  - Editor Background: `#06030A` (Midnight Obsidian)
  - Sidebar Background: `#090510`
  - Tab Active Border: `#ff79c6` (Vibrant Pink)
  - Selection Highlight: `#241336`
  - Font: `'JetBrainsMono Nerd Font', 'Fira Code', monospace`
- **MIME File Associations**: Default handler for `text/markdown`, `text/x-markdown`, and `text/plain` via `~/.config/mimeapps.list` and `xdg-mime`.

---

## 📝 5. Micro Editor
- **Binary**: `micro`
- **Config**: `~/.config/micro/settings.json`
- **Color Scheme**: `catppuccin-macchiato`
- **Usage**: Lightweight, intuitive terminal text editor with standard `Ctrl+S`, `Ctrl+Q`, `Ctrl+C`, `Ctrl+V` keybindings.
