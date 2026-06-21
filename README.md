<div align="center">

<picture>
  <img alt="StemlabSlicer logo" src="icon.png" width="15%" height="15%">
</picture>

# StemlabSlicer

[![GitHub Release](https://img.shields.io/github/v/release/12MICKY/snapmaker-printers?label=latest&color=blue)](https://github.com/12MICKY/snapmaker-printers/releases/latest)
[![Build & Release](https://github.com/12MICKY/snapmaker-printers/actions/workflows/release.yml/badge.svg)](https://github.com/12MICKY/snapmaker-printers/actions/workflows/release.yml)

OrcaSlicer — pre-configured for **8 Snapmaker U1** printers at Stemlabs.  
Download once, connect VPN, and start printing. No manual setup required.

</div>

---

# Download

## One-liner (Recommended)

```bash
curl -sL https://raw.githubusercontent.com/12MICKY/snapmaker-printers/main/install.sh | bash
```

Downloads **StemlabSlicer.AppImage** and creates a desktop shortcut automatically.  
All 8 printers are built into the app — no additional configuration needed.

## Manual Download

📥 **[Download the Latest Release](https://github.com/12MICKY/snapmaker-printers/releases/latest)**

1. Download **StemlabSlicer.AppImage**
2. Make it executable and run:

```bash
chmod +x StemlabSlicer.AppImage
./StemlabSlicer.AppImage
```

> **Requirement:** VPN must be connected to reach the printer network (`10.15.5.0/24`)

---

# Printers

All 8 printers are pre-configured as built-in system profiles — select and print immediately.

| # | Name | IP Address | Web UI |
|:---:|---|:---:|:---:|
| 1 | Snapmaker U1-1 | `10.15.5.66` | [Open](http://10.15.5.66) |
| 2 | Snapmaker U1-2 | `10.15.5.160` | [Open](http://10.15.5.160) |
| 3 | Snapmaker U1-3 | `10.15.5.152` | [Open](http://10.15.5.152) |
| 4 | Snapmaker U1-4 | `10.15.5.69` | [Open](http://10.15.5.69) |
| 5 | Snapmaker U1-5 | `10.15.5.164` | [Open](http://10.15.5.164) |
| 6 | Snapmaker U1-6 | `10.15.5.174` | [Open](http://10.15.5.174) |
| 7 | Snapmaker U1-7 | `10.15.5.165` | [Open](http://10.15.5.165) |
| 8 | Snapmaker U1-8 | `10.15.5.70` | [Open](http://10.15.5.70) |

---

# How to Use

1. **Connect VPN** to reach the `10.15.5.0/24` printer network
2. **Open StemlabSlicer**
3. **Select a printer** from the machine dropdown (Snapmaker U1-1 to U1-8)
4. **Slice and send** — the app connects and uploads directly

### Connectivity Check

```bash
for ip in 10.15.5.66 10.15.5.160 10.15.5.152 10.15.5.69 10.15.5.164 10.15.5.174 10.15.5.165 10.15.5.70; do
  ping -c1 -W2 $ip &>/dev/null && echo "✓ $ip" || echo "✗ $ip (unreachable)"
done
```

---

# How Releases Are Built

A [GitHub Actions workflow](.github/workflows/release.yml) runs automatically on every push and:

1. Downloads the latest **OrcaSlicer** AppImage
2. Patches the icon and app name to **StemlabSlicer**
3. Embeds all 8 Snapmaker U1 printer profiles as **read-only system presets**
4. Publishes the patched AppImage as a GitHub Release

Printer configs are baked into the AppImage at build time — users cannot modify them.

---

# License

StemlabSlicer is built on top of [OrcaSlicer](https://github.com/OrcaSlicer/OrcaSlicer), licensed under the **GNU Affero General Public License, version 3**.
