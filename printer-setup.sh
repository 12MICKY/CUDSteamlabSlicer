#!/bin/bash
# Sets up all 8 Snapmaker U1 printer configs in OrcaSlicer

DIR="$HOME/.config/OrcaSlicer/user/default/machine"
mkdir -p "$DIR"

setup_printer() {
  local name="$1" ip="$2" apikey="$3"
  cat > "$DIR/Snapmaker ${name}.json" <<EOF
{
    "from": "User",
    "inherits": "Snapmaker U1 (0.4 nozzle)",
    "name": "Snapmaker ${name}",
    "print_host": "${ip}",
    "printhost_apikey": "${apikey}",
    "printer_extruder_id": ["1", "2", "3", "4"],
    "printer_extruder_variant": ["Direct Drive Standard", "Direct Drive Standard", "Direct Drive Standard", "Direct Drive Standard"],
    "printer_settings_id": "Snapmaker ${name}",
    "version": "2.4.0.0"
}
EOF
  echo "✓ Snapmaker ${name}  ${ip}"
}

setup_printer "U1-1" "10.15.5.66"  "d24293eb7f22427d9882d633d59f81e4"
setup_printer "U1-2" "10.15.5.160" "f9e7ee5e738748c48bc04858f0fb6eea"
setup_printer "U1-3" "10.15.5.152" "25f37875b8914dcc9481b1ac5de50997"
setup_printer "U1-4" "10.15.5.69"  "0fce7c7d4bd64b81872a959e4ac39d97"
setup_printer "U1-5" "10.15.5.164" "6d2ef4dcd78e46d68c5d0f998bcf23ad"
setup_printer "U1-6" "10.15.5.174" "f4861b66404e4b5680ba5a5d174504e0"
setup_printer "U1-7" "10.15.5.165" "d972cc538b6547e2a239ac78e150d419"
setup_printer "U1-8" "10.15.5.70"  "82dc1d73b4de48c4bd184d28371df314"

echo ""
echo "Done — restart OrcaSlicer to load all printers"
