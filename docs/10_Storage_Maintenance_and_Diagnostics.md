# 10. Storage Maintenance & Diagnostics

## 🔍 System Partitions & Layout

| Partition Device | Mount Point | Filesystem | Total Capacity | Free Space | Utilization | Purpose |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **`/dev/nvme0n1p8`** | `/boot` | `vfat` (FAT32) | 1.0 GB | **870 MB** | **15%** | Limine bootloader, EFI binaries & kernel images |
| **`/dev/nvme0n1p9`** | `/`, `/home`, `/nix`| `btrfs` | 174 GB | **157 GB** | **9%** | NixOS root subvolumes & user data |
| **`/dev/nvme0n1p5`** | `/run/media/.../Scientia`| `ntfs3` | 63 GB | **4.2 GB** | **94%** | Media & backup partition |
| **`/dev/nvme0n1p7`** | `/run/media/.../Lucien` | `ntfs3` | 162 GB | **161 GB** | **1%** | Secondary storage partition |
| **`/dev/nvme0n1p3`** | `/run/media/.../Windows`| `ntfs3` | 554 GB | **81 GB** | **86%** | Windows 11 installation |

---

## 🧹 Maintenance & Space Optimization Commands

### 1. Cleaning the Nix Store (Garbage Collection)
To remove build derivations older than 7 days that are not referenced by active boot generations:
```bash
sudo nix-collect-garbage --delete-older-than 7d
```

### 2. Hardlink Deduplication (Store Optimization)
To deduplicate identical files in `/nix/store` using hard links:
```bash
sudo nix-store --optimise
```

### 3. Automatic Weekly Maintenance
NixOS can automate store garbage collection declaratively inside `/etc/nixos/configuration.nix`:
```nix
nix.gc = {
  automatic = true;
  dates = "weekly";
  options = "--delete-older-than 14d";
};
nix.settings.auto-optimise-store = true;
```

---

## 🛡️ Drive Health & SMART Monitoring
- Drive: **NVMe SSD 1 TB** (`/dev/nvme0n1`)
- SMART Health Self-Assessment: **PASSED** (0 read errors, 0 reallocated sectors).
