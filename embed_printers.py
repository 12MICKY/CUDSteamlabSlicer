import json, os, sys

MACHINE_DIR = os.path.join(sys.argv[1], "resources", "profiles", "Snapmaker", "machine")
VENDOR_PATH = os.path.join(sys.argv[1], "resources", "profiles", "Snapmaker.json")

with open("printers.json") as f:
    printers = json.load(f)

os.makedirs(MACHINE_DIR, exist_ok=True)

for p in printers:
    num = p["name"].split("-")[-1]
    preset = {
        "type": "machine",
        "setting_id": f"SM_U1_{num}",
        "name": p["name"],
        "from": "system",
        "instantiation": "true",
        "inherits": "Snapmaker U1 (0.4 nozzle)",
        "print_host": p["ip"],
        "printhost_apikey": p["apikey"],
        "printer_settings_id": p["name"],
    }
    path = os.path.join(MACHINE_DIR, f"{p['name']}.json")
    with open(path, "w") as f:
        json.dump(preset, f, indent=4)
    print(f"  embedded: {p['name']} -> {p['ip']}")

with open(VENDOR_PATH) as f:
    d = json.load(f)
existing = {e["name"] for e in d["machine_list"]}
for p in printers:
    if p["name"] not in existing:
        d["machine_list"].append({"name": p["name"], "sub_path": f"machine/{p['name']}.json"})
with open(VENDOR_PATH, "w") as f:
    json.dump(d, f, indent=4)
print("  updated Snapmaker.json machine_list")
