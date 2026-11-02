#!/bin/bash
# (c) J~Net 2026
# Raspberry Pi 5 fan controller inspection

echo "=== PWM FAN COOLING DEVICE ==="

FAN="/sys/class/thermal/cooling_device1"

for f in "$FAN"/type "$FAN"/cur_state "$FAN"/max_state; do
    [ -f "$f" ] && echo "$(basename "$f"): $(cat "$f")"
done

echo
echo "=== PWM DEVICES ==="

for d in /sys/class/pwm/pwmchip*; do
    [ -d "$d" ] || continue
    echo "$d"
    for f in "$d"/npwm "$d"/device/uevent; do
        [ -f "$f" ] && cat "$f"
    done
done

echo
echo "=== FAN HARDWARE MONITORING ==="

for f in /sys/class/hwmon/hwmon*/fan*_input; do
    [ -f "$f" ] && echo "$f: $(cat "$f") RPM"
done

echo
echo "=== FAN DEVICE TREE ==="

find /sys/firmware/devicetree/base -iname '*fan*' 2>/dev/null
