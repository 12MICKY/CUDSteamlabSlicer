<div align="center">

<picture>
  <img alt="StemlabSlicer" src="icon.png" width="18%" height="18%">
</picture>

<h1>StemlabSlicer</h1>

<p><strong>OrcaSlicer · Stemlabs Edition</strong></p>

<p>
  A customized build of OrcaSlicer with 8 Snapmaker U1 printers built in.<br>
  Connect to VPN, open the app, and start printing — no setup required.
</p>

[![Build & Release](https://github.com/12MICKY/snapmaker-printers/actions/workflows/release.yml/badge.svg)](https://github.com/12MICKY/snapmaker-printers/actions/workflows/release.yml)
[![GitHub Release](https://img.shields.io/github/v/release/12MICKY/snapmaker-printers?label=release&color=brightgreen)](https://github.com/12MICKY/snapmaker-printers/releases/latest)
[![GitHub Downloads](https://img.shields.io/github/downloads/12MICKY/snapmaker-printers/total?color=blue)](https://github.com/12MICKY/snapmaker-printers/releases)

</div>

---

## Quick Start

```bash
curl -sL https://raw.githubusercontent.com/12MICKY/snapmaker-printers/main/install.sh | bash
```

That's it. The script downloads **StemlabSlicer** and creates a desktop shortcut.  
All 8 printers are already inside the app — just connect VPN and print.

---

## Download

<div align="center">

### 📥 [Download StemlabSlicer (Latest Release)](https://github.com/12MICKY/snapmaker-printers/releases/latest)

</div>

**Linux (AppImage)**

```bash
# Download
wget https://github.com/12MICKY/snapmaker-printers/releases/latest/download/StemlabSlicer.AppImage

# Make executable and run
chmod +x StemlabSlicer.AppImage
./StemlabSlicer.AppImage
```

> [!IMPORTANT]
> VPN must be connected to reach the printer network (`10.15.5.0/24`)

---

## Printers

All 8 printers are embedded as **read-only system presets** inside the app.  
Users can select and print — but cannot change IP addresses or API keys.

| # | Printer | IP Address | Web Interface |
|:---:|:---|:---:|:---:|
| 1 | Snapmaker U1-1 | `10.15.5.66` | [Fluidd ↗](http://10.15.5.66) |
| 2 | Snapmaker U1-2 | `10.15.5.160` | [Fluidd ↗](http://10.15.5.160) |
| 3 | Snapmaker U1-3 | `10.15.5.152` | [Fluidd ↗](http://10.15.5.152) |
| 4 | Snapmaker U1-4 | `10.15.5.69` | [Fluidd ↗](http://10.15.5.69) |
| 5 | Snapmaker U1-5 | `10.15.5.164` | [Fluidd ↗](http://10.15.5.164) |
| 6 | Snapmaker U1-6 | `10.15.5.174` | [Fluidd ↗](http://10.15.5.174) |
| 7 | Snapmaker U1-7 | `10.15.5.165` | [Fluidd ↗](http://10.15.5.165) |
| 8 | Snapmaker U1-8 | `10.15.5.70` | [Fluidd ↗](http://10.15.5.70) |

---

## How to Print

1. **Connect VPN** → network `10.15.5.0/24` must be reachable
2. **Open StemlabSlicer**
3. **Select a printer** from the machine dropdown
4. **Import your model**, slice, and click **Print**

### Check Connectivity

```bash
for ip in 10.15.5.66 10.15.5.160 10.15.5.152 10.15.5.69 10.15.5.164 10.15.5.174 10.15.5.165 10.15.5.70; do
  ping -c1 -W2 $ip &>/dev/null && echo "✓  $ip online" || echo "✗  $ip unreachable"
done
```

---

## How It Works

StemlabSlicer is built automatically by a [GitHub Actions workflow](.github/workflows/release.yml) on every push:

```
OrcaSlicer AppImage (latest)
        │
        ▼
  Extract squashfs
        │
        ├─ Replace icon → Stemlabs logo
        ├─ Rename app  → StemlabSlicer
        └─ Inject printer presets → Snapmaker U1-1 to U1-8
              (from: "system" — read-only, not editable by users)
        │
        ▼
  Repack as StemlabSlicer.AppImage
        │
        ▼
  Publish to GitHub Releases
```

**Printer configs are baked directly into the AppImage** at build time using [`embed_printers.py`](embed_printers.py).

---

## Files

| File | Purpose |
|---|---|
| [`install.sh`](install.sh) | One-liner installer: downloads AppImage + desktop shortcut |
| [`embed_printers.py`](embed_printers.py) | Injects printer presets into squashfs at build time |
| [`printer-setup.sh`](printer-setup.sh) | Manual preset setup for existing OrcaSlicer installations |
| [`printers.json`](printers.json) | Printer list with IPs (JSON) |
| [`printers.csv`](printers.csv) | Printer list with IPs (CSV) |
| [`.github/workflows/release.yml`](.github/workflows/release.yml) | CI/CD: build and publish AppImage |

---

## License

StemlabSlicer is built on [OrcaSlicer](https://github.com/OrcaSlicer/OrcaSlicer), licensed under the **GNU Affero General Public License v3**.
