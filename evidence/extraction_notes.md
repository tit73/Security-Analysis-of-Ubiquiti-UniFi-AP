
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


Transfer to PC

From PC (replace IP with actual AP address):

scp -o HostKeyAlgorithms=+ssh-rsa ubnt@192.168.1.88:"/tmp/*.bin" .


Files obtained

    u-boot.bin (256 KB)

    u-boot-env.bin (64 KB)

    kernel.bin (7552 KB)

    cfg.bin (256 KB)

    EEPROM.bin (64 KB)


binwalk analysis of kernel.bin

binwalk kernel.bin
DECIMAL       HEXADECIMAL     DESCRIPTION
0             0x0             uImage firmware image, header size: 64 bytes, ...
7471104       0x720000        JFFS2 filesystem, big endian, nodes: 4, total size: 196620 bytes

The JFFS2 partition (offset 0x720000) could not be extracted automatically because jefferson was not installed. Attempts to extract it manually failed (possibly empty or corrupt). The squashfs rootfs is embedded inside the LZMA‑compressed kernel data and requires manual extraction using dd + unsquashfs after decompressing the LZMA block.

Next steps (optional)

To extract the squashfs manually:

dd if=kernel.bin of=kernel.lzma bs=64 skip=1
lzma -dc kernel.lzma > kernel_uncompressed
binwalk kernel_uncompressed   # find squashfs offset
dd if=kernel_uncompressed of=rootfs.squashfs bs=1 skip=<OFFSET>
unsquashfs rootfs.squashfs
