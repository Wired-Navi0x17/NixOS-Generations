# 11. Lenovo Legion Pro 7 (82WQ / 16IRX8H) Audio & Microphone Architecture

## 🔍 Hardware Specifications & Audio Topology

| Component | Hardware Specification | Subsystem / Node ID | Active Driver |
| :--- | :--- | :--- | :--- |
| **Laptop Model** | **Lenovo Legion Pro 7 16IRX8H** (Type: `82WQ`) | Subsystem ID: **`17aa:3886`** | - |
| **Audio Controller**| Intel Raptor Lake-S High Definition Audio | `0000:00:1f.3` (`snd_hda_intel`) | `snd_hda_intel` |
| **Primary Codec** | **Realtek ALC287** (`0x10ec0287`) | Card 1 (`PCH`) | `snd_hda_codec_alc269` |
| **Speaker Smart Amp**| **Texas Instruments TAS2781 (TIAS2781)** | Node `0x17` via `i2c-TIAS2781:00` | `snd_hda_scodec_tas2781_i2c` |
| **Internal Mic** | Dual-Array Digital Internal Microphone | Node `0x12` | Realtek ALC287 Internal Mic |
| **Headset Mic** | 3.5mm Combo Analog Microphone Jack | Node `0x19` | Realtek ALC287 External Mic |
| **Headphone Out** | 3.5mm Stereo Headphone Output Jack | Node `0x21` | Realtek ALC287 Headphone Out |
| **GPU HDMI / DP** | NVIDIA AD103 GPU Audio + Intel Raptor Lake HDMI | Card 0 (`NVidia`) | `snd_hda_intel` |

---

## 💡 Gen 8 (82WQ / TAS2781) vs. Gen 10 (16IAX10 / AW88399)

- **Gen 10 (2025/2026 16IAX10)** uses Awinic AW88399 smart amplifier chips which require custom kernel patches (`marco-giunta/legion-pro7-gen10-audio`).
- **Your Machine (Gen 8 / 16IRX8H / 82WQ)** uses **Texas Instruments TAS2781 Smart Amp** + **Realtek ALC287** (`17aa:3886`).
- **Why internal speakers previously failed**: Linux puts the TAS2781 amplifier into power-saving suspend (`power/control = auto`), causing the speakers to mute or power down.
- **Why internal mic had hissing**: Default ALSA profiles apply +30 dB of digital boost (`Internal Mic Boost`) and applications (Discord, web browsers) auto-raise gain to 100%.

---

## ⚙️ Declarative NixOS Solution

### 1. TAS2781 Persistence Daemon (`legion-tas2781-speaker-fix.service`)
Configured in `/etc/nixos/configuration.nix`:
- Automatically triggers on boot and resume from suspend (`multi-user.target`, `post-resume.target`).
- Sets `/sys/bus/i2c/drivers/tas2781-hda/i2c-TIAS2781:00/power/control` to `on`.
- Disables `snd_hda_intel` power-saving (`power_save=0`).
- Executes `Speaker Force Firmware Load` to activate internal stereo speaker channels.
- Locks `Internal Mic Boost` to `0%` (0.00 dB) and sets `Capture` to `35%`.

### 2. WirePlumber Auto-Gain Protection
Configured at `~/.config/wireplumber/wireplumber.conf.d/90-no-mic-auto-gain.conf`:
- Blocks Discord, Chrome, Chromium, Firefox, Electron, and Steam from automatically raising microphone gain.

---

## 🎛️ Installed Audio Management Tools

| Application | Command | Purpose |
| :--- | :--- | :--- |
| **EasyEffects** | `easyeffects` | Studio-grade DSP audio effects, RNNoise AI mic noise reduction & equalizer |
| **PulseAudio Volume Control** | `pavucontrol` | Audio device routing, volume monitoring, profile switching |
| **PipeWire Graph Manager** | `qpwgraph` | Interactive visual patchbay for PipeWire audio streams |
| **ALSA Utilities** | `amixer` / `alsamixer` | Low-level ALSA mixer controls |
