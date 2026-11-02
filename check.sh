# (c) J~Net 2026

echo "=== Character device registrations ==="
grep -E '(^ *100 |vcio)' /proc/devices

echo
echo "=== VCIO device ==="
stat /dev/vcio

echo
echo "=== Thermal sensors ==="
for f in /sys/class/thermal/thermal_zone*/temp; do
    [ -f "$f" ] && echo "$f: $(cat "$f")"
done

echo
echo "=== Hardware monitor ==="
for f in /sys/class/hwmon/hwmon*/{name,temp1_input,fan1_input}; do
    [ -f "$f" ] && echo "$f: $(cat "$f")"
done
