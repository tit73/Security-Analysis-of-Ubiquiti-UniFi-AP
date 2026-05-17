# # Ubiquiti UniFi AP (SWX-UAP / UAP-LR) - Security Analysis

**Device**: Ubiquiti UniFi AP (1st generation, FCC ID: SWX-UAP, IC: 6545A-UAP)  
**Firmware**: UBNT-BZ.v4.3.28 (LEDE 17.01.6, kernel 4.4.153)  
**Hardware**: Atheros AR7241 (MIPS 24Kc), 64MB RAM, 8MB flash  

> **Disclaimer**: This analysis documents **factory-default behavior**, not hidden vulnerabilities. However, some design choices may pose security risks depending on deployment.

## Quick Summary

| Finding | Severity | Description |
|---------|----------|-------------|
| UART console exposed | Medium | Physical access required, but gives full U-Boot control |
| U-Boot without password | High | Can modify firmware, boot over TFTP, dump flash |
| Default credentials (`ubnt`/`ubnt`) | High | Not changed on this unit |
| `ubnt` is UID 0 (root) | **Critical** | Any access = root |
| SSH enabled on port 22 | **Critical** | Remote attack vector |
| SSH uses deprecated `ssh-rsa` | Low | Needs client workaround `-o HostKeyAlgorithms=+ssh-rsa` |
| No web interface active | Informational | Only SSH and discovery services |

**Overall CVSS v3.1 (network access)**: **9.8 (Critical)**  
`AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H`

## Evidence

- Full UART boot log ([evidence/uart_boot.log](evidence/uart_boot.log))
- Network services listing ([evidence/network_services.txt](evidence/network_services.txt))
- System information ([evidence/system_info.txt](evidence/system_info.txt))
- Firmware extraction notes ([extraction/extraction_notes.md](extraction/extraction_notes.md))

## Recommendations

1. **Change default password** immediately.
2. **Disable SSH** or switch to key‑based authentication.
3. **Keep the device in a physically secure location**.
4. **Update firmware** to latest version (if available).
5. **Disable UART in production** (if possible).


## License / Use

This analysis is for educational and research purposes only. Perform tests only on devices you own or have explicit permission to audit.
