
---

## 📄 9. `tools/dump_flash.sh`

```bash
#!/bin/sh
# dump_flash.sh - volcado completo de la memoria flash del Ubiquiti AP
# Uso: copiar al AP (ej. /tmp/dump_flash.sh) y ejecutar como root

OUTDIR="/tmp/flash_dump_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$OUTDIR"

for mtd in /dev/mtd[0-9]*; do
    name=$(basename "$mtd")
    outfile="$OUTDIR/${name}.bin"
    echo "Dumping $mtd to $outfile"
    dd if="$mtd" of="$outfile" 2>/dev/null
done

echo "Dump completed. Files saved in $OUTDIR"
ls -lh "$OUTDIR"
