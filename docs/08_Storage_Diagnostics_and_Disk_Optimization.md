# 08. Storage Diagnostics, Maintenance & Boot Partition Optimization

## 📊 1. Drive Partition Layout (`nvme0n1`)

| Partition | Size | Filesystem | Mountpoint | Purpose |
| :--- | :--- | :--- | :--- | :--- |
| `nvme0n1p1` | 100 MB | FAT32 | — | Windows System EFI |
| `nvme0n1p2` | 16 MB | — | — | Microsoft Reserved Partition (MSR) |
| `nvme0n1p3` | 553.6 GB | NTFS | — | Windows 11 OS (C: Drive) |
| `nvme0n1p4` | 973 MB | NTFS | — | Windows Recovery (WinRE) |
| `nvme0n1p5` | 62.3 GB | NTFS | `/run/media/l41n-pr0t0/Scientia` | Data Drive 1 (Scientia) |
| `nvme0n1p6` | 864 MB | NTFS | — | Lenovo Factory Recovery |
| `nvme0n1p7` | 161.1 GB | NTFS | `/run/media/l41n-pr0t0/Lucien` | Data Drive 2 (Lucien) |
| `nvme0n1p8` | **1.0 GB** | FAT32 | **`/boot`** | **Limine Bootloader & Kernel Storage** |
| `nvme0n1p9` | 174 GB | Btrfs | `/` | **NixOS Root System (Btrfs, zstd)** |

---

## 🧹 2. Automatic `/boot` Partition Pruning (Resolved 96% Full Warning)

- **Root Cause**: Previous builds accumulated 17 generation kernels (`bzImage` + `initrd` = ~55MB each), using 981 MB of the 1023 MB partition.
- **Permanent Solution**:
  - Configured [`/etc/nixos/limine-sync.sh`](/etc/nixos/limine-sync.sh) with an active kernel tracking engine.
  - Automatically preserves only the latest 3 generations (`Current`, `Safe Standby`, `Archive`) and prunes all older kernel binaries during rebuilds.
  - **Result**: `/boot` usage dropped from **96% (41MB free) to 17% (858MB free)**.

---

## ⚙️ 3. Nix Garbage Collection Maintenance
- Automated GC service: `nix.gc.automatic = true;` running weekly.
- Manual deep cleanup:
  ```bash
  sudo nix-collect-garbage --delete-older-than 7d
  sudo nix-store --optimise
  ```
