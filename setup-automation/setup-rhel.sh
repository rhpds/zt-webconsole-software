#!/bin/bash

# Downgrade openssh so that the lab will have something to upgrade.

dnf downgrade openssh -y
systemctl restart sshd.service

