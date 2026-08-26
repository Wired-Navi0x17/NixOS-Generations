# 07. CachyOS Backup Migration & Inventory

## 📦 Backup Storage Locations
- **Original Source on NTFS Storage**:
  `/run/media/l41n-pr0t0/Scientia/---/CachyOS/CachyOS_Backup/`
- **Local Verified Copy**:
  `/home/l41n-pr0t0/Downloads/CachyOS_Backup/`
- **Primary Archive**:
  `/home/l41n-pr0t0/Downloads/CachyOS_Backup/cachyos_backup.tar.gz`

---

## 📋 Migration Inventory & Itemized Mapping

| Backup Component | Backup Source Path | NixOS Target Destination | Applied State |
| :--- | :--- | :--- | :--- |
| **SSH Keys** | `Personal/SSH/` | `~/.ssh/` | ✅ Restored (`700` dir, `600` `id_ed25519`, `644` `pub`) |
| **Obsidian Vault** | `Personal/Obsidian/` | `~/Documents/Obsidian/` | ✅ Restored (`_Skills/`, UI/UX datasets) |
| **Personal Scripts**| `Personal/Scripts/` | `~/Scripts/` | ✅ Restored (`best-audio-setup.sh`, `legion.py`, `+x`) |
| **SDDM Video Theme**| `System Reference/SDDM/nier-automata/` | `~/Documents/SDDM_Themes/nier-automata/` | ✅ Restored video theme (`bg.mp4`) |
| **Software Lists** | `Software Lists/` | `~/Documents/Software_Lists/` | ✅ Restored (package & extension lists) |
| **Kitty Config** | `Applications/kitty/kitty.conf` | `~/.config/kitty/kitty.conf` | ✅ 100% synced with repo & images |
| **Kitty Theme** | `Applications/kitty/current-theme.conf` | `~/.config/kitty/current-theme.conf` | ✅ Active (Lain Wired theme) |
| **Kitty Images** | `Applications/kitty/images/` | `~/.config/kitty/images/` | ✅ Restored full avatar gallery |
| **Fish Config** | `Applications/fish/config.fish` | `~/.config/fish/config.fish` | ✅ Sourced with agy & auto-fastfetch |
| **Fish Variables** | `Applications/fish/fish_variables` | `~/.config/fish/fish_variables` | ✅ Restored Pure prompt theme |
| **Fish Plugins** | `Applications/fish/fish_plugins` | `~/.config/fish/fish_plugins` | ✅ Fisher plugin manager restored |
| **Fastfetch Config** | `Applications/fastfetch/config.jsonc` | `~/.config/fastfetch/config.jsonc` | ✅ LainOS layout active |
| **Fastfetch Lain** | `Applications/fastfetch/lain/` | `~/.config/fastfetch/lain/` | ✅ Dynamic avatar assets synced |
| **Fastfetch Script** | `Applications/fastfetch/random_lain.sh`| `~/.config/fastfetch/random_lain.sh`| ✅ Executable with `env bash` |
| **VS Code Config** | `Applications/vscode/settings.json` | `~/.config/Code/User/settings.json` | ✅ Lunar Pink & window tab reuse |
| **VS Code Snippets**| `Applications/vscode/snippets/` | `~/.config/Code/User/snippets/` | ✅ Custom snippets restored |
| **Micro Config** | `Applications/micro/settings.json` | `~/.config/micro/settings.json` | ✅ Catppuccin Macchiato active |
| **Alacritty** | `Applications/alacritty/alacritty.toml`| `~/.config/alacritty/alacritty.toml` | ✅ Restored dark rice |
| **KDE Colors** | `KDE Plasma/kdeglobals` | `~/.config/kdeglobals` | ✅ LainWired color scheme active |
| **KDE Shortcuts** | `KDE Plasma/kglobalshortcutsrc` | `~/.config/kglobalshortcutsrc` | ✅ Custom shortcuts restored |
| **KWin Rules** | `KDE Plasma/kwinrulesrc` | `~/.config/kwinrulesrc` | ✅ Window rules restored |
| **KWin Settings** | `KDE Plasma/kwinrc` | `~/.config/kwinrc` | ✅ KWin decorations synced |
| **Limine Config** | `System Reference/Limine/limine.conf`| `/boot/limine/limine.conf` | ✅ Centered splash & dual-boot |
| **Limine Artwork** | `System Reference/Limine/lain.png` | `/etc/nixos/lain.png` | ✅ Built into boot partition |
| **Lain Wallpapers** | `Scientia/photos/Lain/` | `~/Pictures/Lain/` | ✅ Applied desktop wallpaper |
| **Keyd Remap** | `System Reference/keyd/default.conf`| `/etc/nixos/configuration.nix` | ✅ `keyd.service` active |
