#!/bin/bash
set -e

# 1. Update & upgrade
echo "[1/10] Updating system..."
apt update && apt upgrade -y

# 2. Install dependencies
echo "[2/10] Installing dependencies..."
apt install screen curl iptables build-essential git wget lz4 jq make gcc nano \
automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev \
tar clang bsdmainutils ncdu unzip -y

# 3. Install Python
echo "[3/10] Installing Python..."
apt install python3 python3-pip python3-venv python3-dev -y

# 4. Install Node.js & Yarn
echo "[4/10] Installing Node.js 22 & Yarn..."
apt update
curl -fsSL https://deb.nodesource.com/setup_22.x | bash -
apt install -y nodejs
node -v

# 5. Install Yarn (global & via script)
echo "[5/10] Installing Yarn..."
npm install -g yarn
yarn -v
curl -o- -L https://yarnpkg.com/install.sh | bash
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# 6. Install Cloudflared tunnel
echo "[7/10] Installing Cloudflared Tunnel..."
if ! command -v cloudflared &> /dev/null
then
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    dpkg -i cloudflared-linux-amd64.deb || apt-get install -f -y
    rm cloudflared-linux-amd64.deb
fi
cloudflared --version

# 7. Clone repo gensyn
echo "[8/10] Cloning Gensyn rl-swarm repo..."
if [ ! -d "rl-swarm" ]; then
  git clone https://github.com/gensyn-ai/rl-swarm.git
fi
