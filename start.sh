# (c) J~Net 2026
echo "=== Raspberry Pi firmware devices ==="
ls -l /dev/vcio /dev/vchiq 2>&1

echo
echo "=== Kernel modules ==="
lsmod | grep -Ei 'vchiq|bcm2835|raspberry'

echo
echo "=== Device tree ==="
ls -l /proc/device-tree/soc/ 2>/dev/null | grep -Ei 'vchiq|mailbox|firmware'

echo
echo "=== Kernel messages ==="
sudo dmesg | grep -Ei 'vchiq|vcio|mailbox|firmware|raspberry' | tail -40
