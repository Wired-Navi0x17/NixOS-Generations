# 09. Hardware Graphics, NVIDIA Drivers & Peripherals

## 🎮 1. GPU Hybrid Architecture (NVIDIA PRIME Offload)
This laptop features a dual-GPU hybrid architecture:
- **Integrated GPU (iGPU)**: Intel Corporation Raptor Lake-S UHD Graphics (`PCI:0:2:0`)
- **Discrete GPU (dGPU)**: NVIDIA Corporation GeForce RTX 4090 Laptop GPU AD103M (`PCI:1:0:0`)

---

## ⚙️ 2. NixOS Graphics & Driver Configuration

Configured in `/etc/nixos/configuration.nix`:

```nix
  # Graphics Acceleration (OpenGL / Vulkan 32-bit & 64-bit)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # NVIDIA Video Driver
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
    };
  };
```

---

## 🚀 3. How to Run Applications on the RTX 4090 dGPU

By default, the system runs on the power-efficient Intel UHD graphics to keep the machine cool and quiet. When you want full RTX 4090 power for games, 3D rendering, or AI workloads:

### Using the `nvidia-offload` wrapper:
```bash
nvidia-offload <application_name>
```
*Example*: `nvidia-offload blender`, `nvidia-offload steam`, `nvidia-offload vkmark`

### Launching NVIDIA Settings:
```bash
nvidia-settings
```

---

## 📷 4. Camera & Webcam Application: Kamoso
- **Application**: **Kamoso** (`kdePackages.kamoso`)
- **Version**: `26.04.3`
- **Features**: Native Qt 6 / KDE Plasma camera viewer, image capture, video recording, and real-time visual filters.
- **User Groups**: User `l41n-pr0t0` is added to the `video` group for direct hardware device access (`/dev/video*`).
- **Launch Command**: `kamoso` or launch from KDE Application Launcher.

---

## 💾 5. Scientia NTFS Drive Declarative Mount & Permissions

- **Partition**: `/dev/nvme0n1p5` (`UUID: E45C6FF55C6FC0C2`, Label: `Scientia`)
- **Mount Point**: `/run/media/l41n-pr0t0/Scientia`
- **Configuration**:
  ```nix
  fileSystems."/run/media/l41n-pr0t0/Scientia" = {
    device = "/dev/disk/by-uuid/E45C6FF55C6FC0C2";
    fsType = "ntfs3";
    options = [
      "rw"
      "uid=1001"
      "gid=100"
      "umask=000"
      "dmask=0000"
      "fmask=0000"
      "iocharset=utf8"
      "nofail"
    ];
  };
  ```
- **Permission Guarantees**: `dmask=0000` and `fmask=0000` ensure all files and folders (including `Navi`, `Github`, `Programming`) are permanently `0777` with full cut, move, delete, and write permissions for user `l41n-pr0t0`.
