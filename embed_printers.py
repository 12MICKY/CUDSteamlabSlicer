import json, os, sys

MACHINE_DIR = os.path.join(sys.argv[1], "resources", "profiles", "Snapmaker", "machine")
VENDOR_PATH = os.path.join(sys.argv[1], "resources", "profiles", "Snapmaker.json")

printers = [
    ("1", "10.15.5.66",  "d24293eb7f22427d9882d633d59f81e4"),
    ("2", "10.15.5.160", "f9e7ee5e738748c48bc04858f0fb6eea"),
    ("3", "10.15.5.152", "25f37875b8914dcc9481b1ac5de50997"),
    ("4", "10.15.5.69",  "0fce7c7d4bd64b81872a959e4ac39d97"),
    ("5", "10.15.5.164", "6d2ef4dcd78e46d68c5d0f998bcf23ad"),
    ("6", "10.15.5.174", "f4861b66404e4b5680ba5a5d174504e0"),
    ("7", "10.15.5.165", "d972cc538b6547e2a239ac78e150d419"),
    ("8", "10.15.5.70",  "82dc1d73b4de48c4bd184d28371df314"),
]

for num, ip, apikey in printers:
    preset = {
        "type": "machine",
        "setting_id": f"SM_U1_{num}",
        "name": f"Snapmaker U1-{num}",
        "from": "system",
        "instantiation": "true",
        "inherits": "Snapmaker U1 (0.4 nozzle)",
        "print_host": ip,
        "printhost_apikey": apikey,
        "printer_settings_id": f"Snapmaker U1-{num}",
    }
    path = os.path.join(MACHINE_DIR, f"Snapmaker U1-{num}.json")
    with open(path, "w") as f:
        json.dump(preset, f, indent=4)
    print(f"  embedded: Snapmaker U1-{num} -> {ip}")

with open(VENDOR_PATH) as f:
    d = json.load(f)
existing = {e["name"] for e in d["machine_list"]}
for num, _, _ in printers:
    name = f"Snapmaker U1-{num}"
    if name not in existing:
        d["machine_list"].append({"name": name, "sub_path": f"machine/Snapmaker U1-{num}.json"})
with open(VENDOR_PATH, "w") as f:
    json.dump(d, f, indent=4)
print("  updated Snapmaker.json machine_list")
