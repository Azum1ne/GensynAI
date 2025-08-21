<img width="2476" height="898" alt="Gensyn" src="https://github.com/user-attachments/assets/bb7a4d89-fdc6-42ca-ae40-4a71996a563f" />

* Official Docs [Gensyn](https://github.com/gensyn-ai/rl-swarm)
* If you want to run with CPU Only , use this guide [0xmoei](https://github.com/0xmoei/gensyn-ai)

# Simple Guide to Run Gensyn RL-SWARM Testnet Node on Quickpod (RTX 3090)
This guide explains how to quickly run a **Gensyn RL-SWARM testnet node** using a rented GPU cloud instance from [Quickpod.io](https://quickpod.io).  
It is optimized for **RTX 3090** instances.

## 1. Prepare Your Quickpod Environment
 Sign up or log in at [Quickpod.io](https://quickpod.io).
  * Go to **Templates**.
  * Search for **"Jupyter Lab CUDA 12.6"**.
(This template makes it easy to back up your `swarm.pem` file or import your old one if you have run Gensyn before.)
  * Clone the template 

<img width="600" height="792" alt="Screenshot 2025-08-21 092727" src="https://github.com/user-attachments/assets/8a500c13-9d47-4267-bf45-47b36c3e4fd8" />

 * and add the following options under **Docker Options**
`--shm-size=16g` or `--shm-size=24g`
* Save the template.
* Select the GPU RTX 3090 using the edited template.
* Set your disk space to **50GB**
* Create the Pod.
* Go to **Pods**, wait until it finishes deploying, then click Connect.
You can connect either via **Web Terminal** or **SSH command** (just copy & paste to your terminal).

## 2. Download and Run the Installer
```bash
wget https://raw.githubusercontent.com/Azum1ne/GensynAI/main/installer.sh
```
```bash
chmod +x installer.sh
```
```bash
./installer.sh
```
 * Wait until the installation finishes.

 * If you are running a new node, you can only back up your swarm.pem file once the node is running by connecting to Jupyter Lab and locating your swarm.pem file in the **rl-swarm** directory.
 * `If you already have an old swarm.pem file`:
   * Connect to Jupyter Lab.
   * Drag & drop your old **swarm.pem** into the **rl-swarm** directory.

## 3. Run RL-SWARM in a Screen Session
```bash
screen -S swarm
```
```bash
cd rl-swarm
```
```bash
python3 -m venv .venv
```
```bash
. .venv/bin/activate
```
```bash
pip install --force-reinstall transformers==4.51.3 trl==0.19.1
```
```bash
pip freeze
```
```bash
./run_rl_swarm.sh
```

 * Wait until you are prompted to log in.

## 4. Login with Cloudflared Tunnel
* Detach from screen with **CTRL A + D**, then run:
```bash
cloudflared tunnel --url http://localhost:3000
```
* You will see a URL like: **https://xxx.xxxx.xxxxx.trycloudflare.com**
* Copy & paste the URL into your browser.
* Login using your email.

<img width="500" height="432" alt="Screenshot 2025-08-21 105617" src="https://github.com/user-attachments/assets/7645a3f2-072f-41ad-b3c7-12de8f800c36" />

* Once logged in, press **CTRL+C** to stop cloudflared.
* Re-attach to your screen session:

```bash
screen -r swarm
```
## 5. Prompts During Setup
# You may see prompts like:
`Would you like to push models you train in the RL swarm to the Hugging Face Hub? [y/N] : (PRESS N)`

`Enter the name of the model you want to use in huggingface repo/name format, or press [Enter] to use the default model. : (Press Enter)`
* press N for HuggingFace and Press Enter to use the default model.
* Make sure your node is running properly.
<img width="1000" height="700" alt="image" src="https://github.com/user-attachments/assets/1d85776b-557c-49fb-b6b9-5cb124550a4b" />


## 6. GSWARM TELEGRAM BOT
* You can monitor your node by running the GSwarm Telegram bot. [Gswarm](https://gswarm.dev/docs)
* and claim your **GSWARM** Role by join [discord](https://discord.gg/gensyn)

## NOTES 
* Official Dashboard [dashboard](dashboard.gensyn.ai), login to check your node peer id, EOA Address. 
* To run Gswarm, you need `EOA Address` you can find it on Dashboard.
* in the current version,you will get 3 participations, every 3 hours.
* So if you don’t get any updates from Telegram after more than 3 hours, you should check your node.
# If there’s an update later
* re-attach screen
```bash
screen -r swarm
```
* Stop your node using `CTRL+C`
```bash
git pull
```
* then re-run your node
```bash
./run_rl_swarm.sh
```









