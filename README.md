# 🌌 NixOS Generations Archive & Declarative Workstation Backups

Automated generation tracking, system snapshots, declarative derivations, and documentation suite for the Lenovo Legion Pro 7 (16IRX8H) workstation.

---

## 📂 Repository Structure

```
.
├── current/                        # Active NixOS system configuration & derivations
│   ├── configuration.nix           # Main system declaration
│   ├── hardware-configuration.nix  # Hardware kernel modules & disk mappings
│   ├── limine-sync.sh              # Limine UEFI bootloader dynamic synchronizer
│   └── pkgs/                       # Custom packaged derivations (Zen, PWCC, Themes)
├── generations/                    # Versioned generation snapshots with changelogs
│   ├── gen-17/                     # Generation 17 (Zen Browser, Keyd PrtSc, Clean Limine)
│   └── ...
├── docs/                           # Master technical documentation (13 Chapters)
└── scripts/
    └── backup-generation.sh        # Automated generation backup & commit engine
```

---

## 📜 Generation History

| Generation | Date | Kernel | Major Highlights |
| :--- | :--- | :--- | :--- |
| **Gen 22** | 2026-08-30 | `6.18.46` | SDDM NieR Practical HUD Suite + KDE Plasma 6 Lock Screen package, ORV System Status Window, Show/Hide password toggle, live CapsLock detection, crystal-clear video wallpaper, merged power grid |
| **Gen 17** | 2026-08-26 | `6.18.46` | Zen Browser 1.21.15b + transparent CSS, Keyd PrtSc Spectacle snip, 1:1 Limine layout, /boot pruning (83% free), Meta+D shortcut fix |
| **Gen 16** | 2026-08-26 | `6.18.46` | Limine console ASCII tofu fix, LainWired color scheme system-wide package, login persistence |
| **Gen 15** | 2026-08-26 | `6.18.46` | PipeWire Controller (pwcc) package, studio mic 5-stage DSP, smart video wallpaper SDDM |

---

## 🚀 How to Backup a Generation
Whenever you rebuild your NixOS system:
```bash
~/Workspace/Github/NixOS-Generations/scripts/backup-generation.sh
```
