# 03. Keyd Hardware Daemon & Key Remapping

## ⌨️ Overview
**keyd** is a low-level key remapping daemon that runs as a systemd service (`keyd.service`). It intercepts input events directly at the Linux `evdev` kernel layer, making remaps universal across Wayland, X11, virtual terminals, and all desktop applications.

---

## 🔧 NixOS Configuration
Keyd is declared in `/etc/nixos/configuration.nix` under `services.keyd`:

```nix
services.keyd = {
  enable = true;
  keyboards.default = {
    ids = [ "*" ];
    settings = {
      main = {
        selectivescreenshot = "print";
      };
    };
  };
};
```

---

## ⚙️ Key Mappings

| Hardware Key / Event | Intercepted As | Output Key / Action |
| :--- | :--- | :--- |
| `selectivescreenshot` | Any connected keyboard (`ids = [ "*" ]`) | `print` (Triggers KDE Spectacle / Screen Capture) |

---

## 🔄 Service Management

Check keyd service status:
```bash
systemctl status keyd.service
```

Reload keyd configuration:
```bash
sudo systemctl restart keyd.service
```
