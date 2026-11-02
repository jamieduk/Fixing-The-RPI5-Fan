#!/bin/bash
# (c) J~Net 2026
# Raspberry Pi 5 - temporary maximum fan test
#
# sudo ./check5.sh
#
FAN="/sys/class/thermal/cooling_device1"
RPM="/sys/class/hwmon/hwmon3/fan1_input"

if [ ! -w "$FAN/cur_state" ]; then
    echo "ERROR: Fan controller is not writable."
    exit 1
fi

ORIGINAL=$(cat "$FAN/cur_state")

restore_fan() {
    echo "$ORIGINAL" > "$FAN/cur_state"
    echo
    echo "Original cooling state restored: $ORIGINAL"
}

trap restore_fan EXIT

echo "Original fan state: $ORIGINAL"
echo "Setting fan to maximum speed..."

echo 4 > "$FAN/cur_state"

sleep 8

echo
echo "=== FAN TEST RESULTS ==="
echo "Cooling state: $(cat "$FAN/cur_state")"
echo "Maximum state: $(cat "$FAN/max_state")"
echo "Fan RPM: $(cat "$RPM")"
