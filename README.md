# Snapmaker U1 — OrcaSlicer Setup

One-command setup to install OrcaSlicer with all 8 Snapmaker U1 printers pre-configured and ready to use.

---

## Quick Start

```bash
curl -sL https://raw.githubusercontent.com/12MICKY/snapmaker-printers/main/install.sh | bash
```

This will:
- Download OrcaSlicer (latest build from this repo)
- Create a desktop shortcut
- Configure all 8 printers with IP addresses and API keys

Then launch OrcaSlicer — all printers appear immediately, no manual setup needed.

> **Requirement:** VPN must be connected to reach the printer network (`10.15.5.0/24`)

---

## Printers

| # | Name | IP Address | Fluidd Web UI |
|---|---|---|---|
| 1 | Snapmaker U1-1 | `10.15.5.66` | http://10.15.5.66 |
| 2 | Snapmaker U1-2 | `10.15.5.160` | http://10.15.5.160 |
| 3 | Snapmaker U1-3 | `10.15.5.152` | http://10.15.5.152 |
| 4 | Snapmaker U1-4 | `10.15.5.69` | http://10.15.5.69 |
| 5 | Snapmaker U1-5 | `10.15.5.164` | http://10.15.5.164 |
| 6 | Snapmaker U1-6 | `10.15.5.174` | http://10.15.5.174 |
| 7 | Snapmaker U1-7 | `10.15.5.165` | http://10.15.5.165 |
| 8 | Snapmaker U1-8 | `10.15.5.70` | http://10.15.5.70 |

---

## Installation Options

### Option 1 — One-liner (recommended)

```bash
curl -sL https://raw.githubusercontent.com/12MICKY/snapmaker-printers/main/install.sh | bash
```

Downloads OrcaSlicer from this repo's [latest release](https://github.com/12MICKY/snapmaker-printers/releases/latest) and sets up all printer configs automatically.

### Option 2 — Download from Releases

1. Go to [Releases](https://github.com/12MICKY/snapmaker-printers/releases/latest)
2. Download `OrcaSlicer.AppImage`
3. Make it executable and run:

```bash
chmod +x OrcaSlicer.AppImage
./OrcaSlicer.AppImage
```

4. Download `snapmaker-u1-configs.tar.gz`, extract it, then run:

```bash
bash install.sh
```

### Option 3 — Configs only (OrcaSlicer already installed)

```bash
bash printer-setup.sh
```

Restart OrcaSlicer after running — all 8 printers will appear in the printer list.

---

## Connectivity Check

Run this to verify VPN is connected and all printers are reachable:

```bash
for ip in 10.15.5.66 10.15.5.160 10.15.5.152 10.15.5.69 10.15.5.164 10.15.5.174 10.15.5.165 10.15.5.70; do
  ping -c1 -W2 $ip &>/dev/null && echo "✓ $ip" || echo "✗ $ip (unreachable)"
done
```

---

## Files

| File | Description |
|---|---|
| `install.sh` | Full setup: downloads OrcaSlicer + installs all printer configs |
| `printer-setup.sh` | Installs printer configs only (skips OrcaSlicer download) |
| `printers.json` | Machine list with IPs and API keys (JSON) |
| `printers.csv` | Machine list with IPs and API keys (CSV) |

---

## How Releases Are Built

A [GitHub Actions workflow](.github/workflows/release.yml) runs on a self-hosted runner and automatically:

1. Fetches the latest OrcaSlicer AppImage from the official release
2. Bundles printer configs into `snapmaker-u1-configs.tar.gz`
3. Publishes everything as a GitHub Release

Trigger a new release manually from the [Actions tab](https://github.com/12MICKY/snapmaker-printers/actions/workflows/release.yml).
