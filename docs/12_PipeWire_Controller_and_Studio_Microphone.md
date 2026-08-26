# 12. PipeWire Controller, Native Hardware Audio & On-Demand EasyEffects

## 🔊 1. Native Hardware Speaker Setup (Default Audio Path)

To prevent routing glitches and volume attenuation, the system outputs directly to the Lenovo Legion Pro 7's physical hardware:

- **Default Sink**: `Built-in Audio Analog Stereo` (`ALC287 Analog` + `TAS2781 Smart Amp`).
- **Default Source**: `Built-in Audio Analog Stereo` (with `Internal Mic Boost` locked to 0 dB).
- **Direct Streaming**: All applications (Firefox, Discord, Spotify, games) play directly through hardware without latency or DSP processing by default.
- **Hardware Boost**: `Speaker Analog Volume` is set to `20` (+21 dB analog smart amplifier gain), with `PCM` and `Master` at 100%.

---

## 🎛️ 2. On-Demand EasyEffects DSP Processing

EasyEffects is **disabled on boot / startup** and only runs when explicitly launched by the user:

- **Presets Library**: All presets (`Dolby Atmos`, `Bass Enhancing + Perfect EQ`, `Advanced Auto Gain`, `Loudness+Autogain`, `Legion_Studio_Voice`) are stored in `~/.local/share/easyeffects/` with 25+ `.irs` impulse response filters.
- **Manual Launch**: Whenever you want Dolby Atmos spatial audio or extra bass enhancement, simply launch **EasyEffects** or **PipeWire Controller (`pwcc`)**. When closed, the audio automatically routes directly through native hardware.
