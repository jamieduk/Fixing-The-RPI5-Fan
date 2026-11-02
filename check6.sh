#!/bin/bash
# (c) J~Net 2026
# Raspberry Pi 5 fan controller detailed diagnostics

FAN="/sys/class/thermal/cooling_device1"

echo "=== FAN DEVICE ==="
readlink -f "$FAN/device"

echo
echo "=== COOLING STATE ==="
for f in "$FAN"/type "$FAN"/cur_state "$FAN"/max_state; do
    [ -f "$f" ] && echo "$(basename "$f"): $(cat "$f")"
done

echo
echo "=== FAN PWM HARDWARE ==="
for d in /sys/class/hwmon/hwmon3; do
    for f in "$d"/*; do
        [ -f "$f" ] && echo "$(basename "$f"): $(cat "$f" 2>/dev/null)"
    done
done

echo
echo "=== FAN DEVICE TREE PROPERTIES ==="
for f in /sys/firmware/devicetree/base/cooling_fan/*; do
    [ -f "$f" ] && echo "$(basename "$f"): $(od -An -tx1 "$f" | head -c 200)"
done

echo
echo "=== KERNEL FAN MESSAGES ==="
sudo dmesg | grep -Ei 'pwm.fan|cooling.fan|fan|pwm' | tail -40
