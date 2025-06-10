#!/bin/bash

# Downgrade openssh so that the lab will have something to upgrade.

#dnf downgrade openssh -y
#systemctl restart sshd.service

# Enable cockpit functionality in showroom.
echo "[WebService]" > /etc/cockpit/cockpit.conf
echo "Origins = https://cockpit-$(hostname -f|cut -d"-" -f2).apps.$(grep search /etc/resolv.conf| grep -o '[^ ]*$')" >> /etc/cockpit/cockpit.conf
echo "AllowUnencrypted = true" >> /etc/cockpit/cockpit.conf
systemctl enable --now cockpit.socket

# Create rhel user and set password
useradd rhel
usermod -aG wheel rhel
#echo redhat | passwd --stdin rhel