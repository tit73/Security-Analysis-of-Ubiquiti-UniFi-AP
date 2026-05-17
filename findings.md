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
