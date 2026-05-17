
---

## 📄 8. `extraction/extraction_notes.md`

```markdown
# Firmware Extraction Notes

## Commands used (inside AP as root)

```bash
dd if=/dev/mtd0 of=/tmp/u-boot.bin
dd if=/dev/mtd1 of=/tmp/u-boot-env.bin
dd if=/dev/mtd2 of=/tmp/kernel.bin
dd if=/dev/mtd3 of=/tmp/cfg.bin
dd if=/dev/mtd4 of=/tmp/EEPROM.bin
