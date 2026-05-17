# Detailed Findings

## 1. UART Console (Physical Access)

| Item | Detail |
|------|--------|
| Pins | `3v`, `SOUT`, `SIN`, `GND` (labeled on PCB) |
| Baud rate | 115200, 8N1 |
| Access | Boot logs printed, can interrupt autoboot |

**U-Boot access** (no password):

Hit any key to stop autoboot: 0
ar7240>


**Commands available**: `printenv`, `setenv`, `bootm`, `tftpboot`, `erase`, `cp`, `mtdparts`, `flinfo`, etc.

**Risk**: Full control over flash memory, ability to boot custom images via TFTP.

---

## 2. Default Credentials and Privileges

- Username: `ubnt`
- Password: `ubnt`
- UID: `0` (root)

Confirmed with:
```bash
id
# uid=0(ubnt) gid=0(root) groups=0(root)


Risk: Any service using these credentials gives immediate root.

3. Network Services (Factory Default)

From netstat -tulpn:
Proto	Local Address	Service	PID
tcp	0.0.0.0:22	dropbear (SSH)	1386
tcp	:::22	dropbear (SSH)	1386
udp	0.0.0.0:10001	mcad (discovery)	1228
udp	0.0.0.0:32911	ntpclient	1223
udp	0.0.0.0:55517	mcad	1228

SSH details:

    Only ssh-rsa and ssh-dss offered (deprecated).

    Modern clients need -o HostKeyAlgorithms=+ssh-rsa to connect.

Risk: Remote root access if default password is unchanged and network is reachable.

4. Firmware Extraction

Partitions (cat /proc/mtd):

dev:    size   erasesize  name
mtd0: 00040000 00010000 "u-boot"
mtd1: 00010000 00010000 "u-boot-env"
mtd2: 00760000 00010000 "kernel"
mtd3: 00040000 00010000 "cfg"
mtd4: 00010000 00010000 "EEPROM"

Dump commands used (as root):
dd if=/dev/mtd0 of=/tmp/u-boot.bin
dd if=/dev/mtd1 of=/tmp/u-boot-env.bin
dd if=/dev/mtd2 of=/tmp/kernel.bin
dd if=/dev/mtd3 of=/tmp/cfg.bin
dd if=/dev/mtd4 of=/tmp/EEPROM.bin

binwalk kernel.bin output:
DECIMAL       HEXADECIMAL     DESCRIPTION
0             0x0             uImage firmware image, MIPS32 Linux
7471104       0x720000        JFFS2 filesystem, big endian

Note: The JFFS2 partition extraction with jefferson failed (possibly empty or corrupt). The squashfs rootfs is inside the LZMA-compressed data and requires manual extraction.



