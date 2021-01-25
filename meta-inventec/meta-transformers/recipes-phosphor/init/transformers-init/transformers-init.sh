#!/bin/sh

# Work around for systemd-networkd.service fail
echo "Sleep 60s to wait systemd-networkd.service fail"
sleep 60
echo "Do udhcpc"
/sbin/udhcpc eth0
