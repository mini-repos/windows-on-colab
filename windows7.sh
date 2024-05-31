# Download the latest Ngrok version
wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz > /dev/null 2>&1
tar -xvzf ngrok-v3-stable-linux-amd64.tgz > /dev/null 2>&1

# Prompt user for Ngrok authtoken
read -p "Paste authtoken here (Copy and Ctrl+V to paste then press Enter): " CRP

# Authenticate Ngrok with the provided authtoken
./ngrok authtoken $CRP

# Start Ngrok tunnel on port 5900 and log output
nohup ./ngrok tcp 5900 &>/dev/null &

echo Please wait for installing...
sleep 20 # Add a delay to ensure Ngrok has time to start

# Update package lists
sudo apt update -y > /dev/null 2>&1

echo "Installing QEMU (2-3m)..."
# Install QEMU and curl
sudo apt install qemu-system-x86 curl -y > /dev/null 2>&1

echo Downloading Windows Disk...
# Download Windows QCOW2 disk image
curl -L -o lite7.qcow2 https://app.vagrantup.com/thuonghai2711/boxes/WindowsQCOW2/versions/1.0.3/providers/qemu.box

echo "Windows 7 x86 Lite On Google Colab"

echo Your VNC IP Address:
# Fetch and display the Ngrok public URL
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'

echo "Note: Use Right-Click Or Ctrl+C To Copy"
echo "Please Keep Colab Tab Open, Maximum Time 12h"
echo Script by fb.com/thuong.hai.581

# Start QEMU with specified parameters
sudo qemu-system-x86_64 -vnc :0 -hda lite7.qcow2 -smp cores=2 -m 8192M -machine usb=on -device usb-tablet > /dev/null 2>&1
