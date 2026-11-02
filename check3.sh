# (c) J~Net 2026
echo "=== Cooling fan ==="
find /proc/device-tree -iname '*fan*' 2>/dev/null

echo
echo "=== Cooling devices ==="
for f in /sys/class/thermal/cooling_device*/type; do
    [ -f "$f" ] && echo "$(dirname "$f"): $(cat "$f")"
done

echo
echo "=== Temperature ==="
cat /sys/class/thermal/thermal_zone0/temp
