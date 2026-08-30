# Generation 22 Changelog & System State

- **Date**: 2026-08-30
- **Kernel**: Linux 6.18.46 (64-bit LTS)
- **Profile Link**: `/nix/var/nix/profiles/system-22-link`
- **System Hash**: `/nix/store/7l0qxkspdlnp6np3cyy7g8xahpwjbbrn-nixos-system-wired_navi0x17-26.05.8409.f4f698677b11`

---

## 🌟 Major Highlights & Accomplishments:

1. **SDDM Practical NieR:Automata Cyberpunk Suite**:
   - Upgraded `/home/l41n-pr0t0/Documents/SDDM_Themes/nier-automata/` into a high-density practical HUD greeter.
   - **Show/Hide Password**: Added interactive `[👁 / 🔒]` button and `Alt + P` shortcut.
   - **Caps Lock Detection**: Real-time `[⚠️ CAPS ON]` indicator and warning label.
   - **Merged Power Controls**: Integrated 4-button quick-action grid (`☾ Suspend`, `↻ Reboot`, `⏻ Power Off`, `❄ Hibernate`) directly under the passphrase box.
   - **Crystal-Clear Video Wallpaper**: Removed the yellowish `#c0bc9e` beige overlay wash to display true-to-life vibrant colors and deep blacks.

2. **KDE Plasma 6 Lock Screen Package (`kscreenlocker`)**:
   - Implemented custom Plasma 6 shell package in `~/.local/share/plasma/shells/org.kde.plasma.desktop/`.
   - **KDE PAM Hook**: Connected with `authenticator.respond(pwInput.text)` and `authenticator.onSucceeded -> Qt.quit()` for instant session unlocking.
   - **Smart Video Wallpaper Integration**: Seamless overlay on top of `Untitled design.mp4` video background.
   - 100% feature parity with the SDDM greeter.

3. **Omniscient Reader's Viewpoint (ORV) System Status Window**:
   - Completely redesigned the `HARDWARE` tab into a single, cohesive ORV Holographic Status Window.
   - Chamfered top-left corner cut, bottom-right 45° diagonal hatched stripes (`///`), title controls `[—][⧉][✕]`, and decorative data-chip blocks on outer borders.
   - Real-time **Lenovo Legion Pro 7 16IRX8H (82WQ)** specifications:
     - 32 × 13th Gen Intel® Core™ i9-13900HX (24C / 32T @ 5.40 GHz)
     - NVIDIA GeForce RTX 4090 Laptop GPU (16 GiB GDDR6 // 175W TGP)
     - Mesa Intel® UHD Graphics (Raptor Lake-HX)
     - 32 GiB DDR5 Dual-Channel (31.1 GiB Usable) with live memory gauge
     - 16.0" 2560×1600 @ 240.00 Hz IPS Display
     - Texas Instruments TAS2781 Dual Smart-Amplifiers
     - Live Battery % (`80% AC ONLINE`) and Load Averages

4. **Streamlined 6-Tab Navigation**:
   - Navigation: `UNLOCK` / `LOGIN`, `HARDWARE`, `NETWORK`, `DISPLAY`, `DIAGS`, `SHORTCUTS`.
   - Dynamic UI Scale Tuner (`[-] 0.90x [+]`) and emergency TTY cheatsheet (`Ctrl+Alt+F3`).
