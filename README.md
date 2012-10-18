# 💡 RPMLight / Lightpack (2012) — Delphi + Arduino FastSPI WS2811 TV Ambilight & Pixel Controller

> **Historical Archive (October 2012):** Original Borland Delphi desktop controller (`RPMlight.dpr` / `Controller.pas`) and Arduino `FastSPI_LED` firmware (`RPMFastSPI.ino`, `FastSPIstream.ino`, `MomoFastSPI.ino`, `RPMxmas.ino`) built in **September–October 2012** for real-time screen-captured TV Ambilight and addressable WS2811/TM1809 holiday pixel strips—years before ESP8266/ESP32 WLED existed.

---

## 🛠️ Architecture (2012)

1. **`delphi-controller/` (`RPMlight.dpr`, `Controller.pas`, `Controller.dfm`, `PwrSave.pas`)**
   - Native Win32 Borland Delphi application using `SynaSer` high-speed serial communication (`115200` baud) and GDI `TClipRegion` perimeter screen sampling.
   - Supports **Live TV Ambilight ("Expand" screen-edge capture)**, **Sound-Reactive Mode**, **Animated Pattern Playback**, **Still Color / Per-Channel Calibration**, and automatic Windows power-state sleep/wake (`PwrSave.pas`).
2. **`arduino-firmware/` (`RPMFastSPI.ino`, `FastSPIstream.ino`, `MomoFastSPI.ino`, `RPMxmas.ino`)**
   - Frame-synchronized serial protocol (`0xF0 0x55 0x0F` sync header + raw RGB triplets) driving addressable WS2811 / TM1809 LED strips via `FastSPI_LED` on Pin `D4`.
   - Includes Square-Wave `0x55` (`"UUUU..."`) startup burst for automatic client baud-rate detection, standalone hardware power-on self-test (white ramp → R → G → B), and a 5-minute no-signal watchdog timer that automatically blanks the LEDs when the HTPC sleeps.
   - `RPMxmas.ino`: Standalone holiday roofline pattern generator written in 2012—the direct ancestor of the 2026 **[`wroof-wled-spider`](https://github.com/rpmccormick/wroof-wled-spider)** 1,076-pixel autonomous roofline engine and **[`brilliant-mqtt`](https://github.com/rpmccormick/brilliant-mqtt)** panel camera TV Ambilight engine.

---

## 📂 Repository Contents

```
├── arduino-firmware/
│   ├── RPMFastSPI/RPMFastSPI.ino       # Native RPMLight 115200-baud frame-synced FastSPI receiver
│   ├── FastSPIstream/FastSPIstream.ino # Continuous serial stream receiver
│   ├── MomoFastSPI/MomoFastSPI.ino     # AtmoWin / MomoLight protocol compatibility firmware
│   └── RPMxmas/RPMxmas.ino             # Standalone 2012 holiday addressable LED show firmware
└── delphi-controller/
    ├── RPMlight.dpr                    # Delphi project entry point (Oct 2012)
    ├── RPMlight.bdsproj                # Borland Developer Studio project configuration
    ├── Controller.pas                  # Main screen-capture, audio, pattern & serial controller (1,387 lines)
    ├── Controller.dfm                  # Win32 VCL form layout
    ├── PwrSave.pas                     # Windows power-management & standby hook
    └── synaser.pas / synautil.pas      # Ararat Synapse serial library
```

---

## 📄 License

MIT License — Copyright (c) 2012–2026 Ryan P. McCormick ([Surround View Systems RVA](https://svsrva.com))
