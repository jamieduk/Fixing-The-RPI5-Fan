#!/bin/bash
# (c) J~Net 2026
# Raspberry Pi 5 fan controller diagnostics

CONFIG="/boot/firmware/config.txt"

echo "======================================"
echo " Raspberry Pi 5 Fan Diagnostics"
echo "======================================"

echo
echo "[1] CPU temperature"
awk '{printf "%.2f°C\n",$1/1000}' /sys/class/thermal/thermal_zone0/temp

echo
echo "[2] Fan configuration"
grep -nEi 'fan_temp|cooling_fan|dtoverlay' "$CONFIG" 2>/dev/null || echo "No fan configuration found."

echo
echo "[3] Cooling fan device tree"
find /proc/device-tree -iname '*fan*' 2>/dev/null

echo
echo "[4] Fan-related device tree status"
for f in $(find /proc/device-tree -iname 'cooling_fan' -type d 2>/dev/null); do
    [ -f "$f/status" ] && echo "$f: $(tr -d '\0' < "$f/status")"
done

echo
echo "[5] Hardware monitoring"
for d in /sys/class/hwmon/hwmon*; do
    [ -d "$d" ] || continue
    echo "Device: $d ($(cat "$d/name" 2>/dev/null))"
    for f in "$d"/fan* "$d"/pwm*; do
        [ -f "$f" ] && echo "  $(basename "$f"): $(cat "$f")"
    done
done

echo
echo "[6] Cooling devices"
for d in /sys/class/thermal/cooling_device*; do
    [ -d "$d" ] || continue
    echo "$d: $(cat "$d/type" 2>/dev/null)"
done

echo
echo "======================================"
