#!/bin/bash
set -e

echo -e "\n>>>>> Clean installation...\n"
apt autoremove -y && apt autoclean -y && rm -rf /var/lib/apt/lists/*
rm -rf /tmp/downloaded_packages /tmp/Rtmp*
