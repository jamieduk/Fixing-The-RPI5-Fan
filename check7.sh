#!/bin/bash
# (c) J~Net 2026
# Raspberry Pi 5 - Direct PWM fan test

HWMON="/sys/class/hwmon/hwmon3"
PWM="$HWMON/pwm1"
RPM="$HWMON/fan1_input"

if [ ! -w "$PWM" ]; then
    echo "ERROR: PWM control is not writable."
    exit 1
fi

ORIGINAL=$(cat "$PWM")

restore_pwm() {
    echo "$ORIGINAL" > "$PWM"
    echo
    echo "Original PWM restored: $ORIGINAL"
}

trap restore_pwm EXIT INT TERM

echo "Original PWM: $ORIGINAL"
echo "Original RPM: $(cat "$RPM")"

echo
echo "Setting fan PWM to 255 (100%)..."
echo 255 > "$PWM"

sleep 8

echo
echo "=== TEST RESULTS ==="
echo "PWM: $(cat "$PWM")"
echo "RPM: $(cat "$RPM")"
echo "Cooling state: $(cat /sys/class/thermal/cooling_device1/cur_state)"

echo
echo "Did the fan physically spin?"
