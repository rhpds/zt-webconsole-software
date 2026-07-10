#!/bin/bash

# Downgrade openssh so that the lab will have something to upgrade.

# Unregister and register the VM
dnf -y remove katello-ca-consumer-*
subscription-manager clean
subscription-manager register --activationkey=$ACTIVATION_KEY --org=$ORG_ID --force

dnf downgrade openssh -y
systemctl restart sshd.service

# Enable cockpit functionality in showroom.
echo "[WebService]" > /etc/cockpit/cockpit.conf
echo "Origins = https://cockpit-${GUID}.${DOMAIN}" >> /etc/cockpit/cockpit.conf
echo "AllowUnencrypted = true" >> /etc/cockpit/cockpit.conf
systemctl enable --now cockpit.socket

# Create rhel user and set password
useradd rhel
usermod -aG wheel rhel
#echo redhat | passwd --stdin rhel
