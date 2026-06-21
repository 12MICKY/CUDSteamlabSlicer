# Snapmaker U1 Printers — OrcaSlicer Setup

ไฟล์ config และ script สำหรับตั้งค่า Snapmaker U1 ทั้ง 8 เครื่องใน OrcaSlicer

## Printers

| เครื่อง | IP | API Key |
|---|---|---|
| Snapmaker U1-1 | 10.15.5.66 | d24293eb7f22427d9882d633d59f81e4 |
| Snapmaker U1-2 | 10.15.5.160 | f9e7ee5e738748c48bc04858f0fb6eea |
| Snapmaker U1-3 | 10.15.5.152 | 25f37875b8914dcc9481b1ac5de50997 |
| Snapmaker U1-4 | 10.15.5.69 | 0fce7c7d4bd64b81872a959e4ac39d97 |
| Snapmaker U1-5 | 10.15.5.164 | 6d2ef4dcd78e46d68c5d0f998bcf23ad |
| Snapmaker U1-6 | 10.15.5.174 | f4861b66404e4b5680ba5a5d174504e0 |
| Snapmaker U1-7 | 10.15.5.165 | d972cc538b6547e2a239ac78e150d419 |
| Snapmaker U1-8 | 10.15.5.70 | 82dc1d73b4de48c4bd184d28371df314 |

> เข้าถึงผ่าน VPN เท่านั้น (10.15.5.0/24)

## วิธีใช้

```bash
bash printer-setup.sh
```

รันแล้ว restart OrcaSlicer — จะเห็น U1-1 ถึง U1-8 ใน printer list พร้อมใช้งานทันที

## ไฟล์

| ไฟล์ | คำอธิบาย |
|---|---|
| `printer-setup.sh` | script ติดตั้ง config ทุกเครื่องใน OrcaSlicer |
| `printers.json` | ข้อมูล printer ทุกตัว (JSON) |
| `printers.csv` | ข้อมูล printer ทุกตัว (CSV) |
