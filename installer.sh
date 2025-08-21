#!/bin/bash
set -e

echo "=== Gensyn Node Auto Installer ==="

# 1. Update & upgrade
echo "[1/10] Updating system..."
apt update 
DEBIAN_FRONTEND=noninteractive apt-get -o Dpkg::Options::="--force-confold" upgrade -y

# 2. Install dependencies
echo "[2/10] Installing dependencies..."
sudo apt install screen curl iptables build-essential git wget lz4 jq make gcc nano \
automake autoconf tmux htop nvme-cli libgbm1 pkg-config libssl-dev libleveldb-dev \
tar clang bsdmainutils ncdu unzip -y

# 3. Install Python
echo "[3/10] Installing Python..."
sudo apt install python3 python3-pip python3-venv python3-dev -y

# 4. Install Node.js & Yarn
echo "[4/10] Installing Node.js 22 & Yarn..."
sudo apt update
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo bash -
sudo apt install -y nodejs
node -v

# 5. Install Yarn (global & via script)
echo "[5/10] Installing Yarn..."
npm install -g yarn
yarn -v
curl -o- -L https://yarnpkg.com/install.sh | bash
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# 6. Python libs (transformers & trl specific version)
echo "[6/10] Installing Python libs..."
pip install --force-reinstall transformers==4.51.3 trl==0.19.1
pip freeze

# 7. Install Cloudflared tunnel
echo "[7/10] Installing Cloudflared Tunnel..."
if ! command -v cloudflared &> /dev/null
then
    wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
    sudo dpkg -i cloudflared-linux-amd64.deb || sudo apt-get install -f -y
    rm cloudflared-linux-amd64.deb
fi
cloudflared --version

# 8. Clone repo gensyn
echo "[8/10] Cloning Gensyn rl-swarm repo..."
if [ ! -d "rl-swarm" ]; then
  git clone https://github.com/gensyn-ai/rl-swarm.git
fi