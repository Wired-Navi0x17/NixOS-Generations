# Generation 17 Changelog & System State

- **Date**: 2026-08-26
- **Kernel**: Linux 6.18.46 (Lenovo Legion Pro 7 16IRX8H)
- **Profile Link**: `/nix/var/nix/profiles/system-17-link`

## 🌟 Major Highlights:
1. **Zen Browser Packaging & Integration**:
   - Packaged Zen Browser (`1.21.15b`) from GitHub release tarball with full Wayland/PipeWire/ALSA libraries.
   - Configured custom transparent/blurred `userChrome.css` profile from dotfiles.
2. **Keyd Hardware PrintScreen Fix**:
   - Remapped Lenovo Legion `selectivescreenshot` (code 590) -> `print`.
   - Bound KDE Spectacle `RectangularRegionScreenShot` to `Print` and `Meta+Shift+S`.
3. **Limine Bootloader 1:1 CachyOS Layout**:
   - Top right header branding `wired://boot`.
   - Expanded `[-] NixOS` with arrow pointers `-> linux-nixos` and `-> linux-nixos-safe`.
   - Collapsed `[+] Snapshots` (NixOS Generations archive).
   - Bottom center dynamic cyan kernel diagnostic label.
4. **Boot Partition Storage Optimization**:
   - Implemented automated kernel pruning in `limine-sync.sh`, keeping only the 3 most recent generations.
   - Reduced `/boot` disk usage from 96% (41MB free) to 17% (858MB free).
5. **Standard Desktop Shortcuts Restoration**:
   - Fixed `Meta+D` (Show Desktop), `Meta+W` (Overview), `Meta+Q` / `Alt+F4` (Close Window), and `Meta+L` (Lock Screen).
6. **Native Audio Default & Hardware Volume Boost**:
   - Set direct hardware playback (`ALC287` + `TAS2781`) as default sink.
   - Boosted TAS2781 smart amplifier analog gain to maximum `20` (+21 dB) with ALSA `Internal Mic Boost` locked to 0 dB.
