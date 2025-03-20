#!/bin/bash
set -e

BUILD_SOURCE_DIR=${BUILD_SOURCE_DIR:-/build/}

echo -e "\n>>>>> Install nodejs...\n"
apt remove -y libnode-dev
curl -fsSL https://deb.nodesource.com/setup_current.x | bash - && apt install -y nodejs
echo -e ">>>>> Done\n"

echo -e "\n>>>>> node.js version:"
node -v

echo -e "\n>>>>> npm version:"
npm -v

