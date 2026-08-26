# 05. Terminal Ricing: Kitty, Fish Shell & Fastfetch

## 🐱 1. Kitty Terminal
Kitty is configured 100% identically to the [Wired-Navi0x17/dotfiles-cachyos/kitty](https://github.com/Wired-Navi0x17/dotfiles-cachyos/tree/main/kitty) repository.

- **Configuration File**: `~/.config/kitty/kitty.conf`
- **Theme File**: `~/.config/kitty/current-theme.conf`
- **Fallback Theme**: `~/.config/kitty/light-theme.auto.conf`
- **Image Assets**: `~/.config/kitty/images/`
  - `2406ac8850a3cf299aa6e2f221216307.jpg`
  - `bfc238eafb35cbebade94a734959ae30.jpg`
  - `c4632e785b5ebbf9edb786ff7bbfbab0.jpg`
  - `lainPfp.jpg`
- **Visual Parameters**:
  - `background_opacity 0.70`
  - `background_blur 128`
  - `window_padding_width 10`
  - `window_margin_width 6`
  - `active_border_color #c084fc`
  - `inactive_border_color #3b1f4a`
  - `allow_remote_control yes`
  - `listen_on unix:/tmp/kitty`
  - `font_family JetBrainsMono Nerd Font`

---

## 🐟 2. Fish Shell & Minimalist Prompt
Fish is configured as the **system-wide default login shell** (`users.users."l41n-pr0t0".shell = pkgs.fish;`).

### Minimalist CachyOS Prompt
- **Primary Prompt Function**: `~/.config/fish/functions/fish_prompt.fish`
  - Displays a clean, minimal **`> `** prompt symbol in `#d9a8ff` purple.
  - Automatically displays red error exit codes (e.g. `[1] > `) when a previous command fails.
- **Right Prompt Function**: `~/.config/fish/functions/fish_right_prompt.fish`
  - Displays the current directory (`~` or `~/path`) and git branch/dirty status on the right-hand edge.

---

## ⚡ 3. Fastfetch Dynamic Avatar Ricing

Whenever a new Kitty window opens or `fastfetch` is invoked, a custom wrapper function dynamically displays a rotating high-resolution Lain graphic using the Kitty `icat` image protocol.

- **Configuration**: `~/.config/fastfetch/config.jsonc`
- **Queue Generator**: `~/.config/fastfetch/random_lain.sh`
- **Artwork Gallery**: `~/.config/fastfetch/lain/`
- **Startup Greeting** (in `config.fish`):
  ```fish
  function fish_greeting
      if test "$TERM_PROGRAM" != "vscode" -a "$TERM" != "dumb"
          fastfetch
      end
  end
  ```
