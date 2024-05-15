#!/bin/bash
KEY
# Update package list and upgrade packages
apt-get update && apt-get install -y \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Prompt for the $KEY
read -p "Enter the value for KEY: " KEY

# Download Geth
wget https://github.com/LarissaBlockchain/Core/releases/download/v1.12.0/geth-ubuntu-x86_64

# Create a script to run Geth
cat <<EOF > runnode.sh
#!/bin/bash

# Set permissions for Geth
chmod +x geth-ubuntu-x86_64


# Run Geth with the provided $KEY
./geth-ubuntu-x86_64 --larissa.node=1 -larissa.node.user.key="\$KEY"
EOF

# Set permissions for the script
chmod +x runnode.sh

# Edit crontab to run the script at reboot
(crontab -l ; echo "@reboot sleep 60 && cd /path/to/script && ./runnode.sh") | crontab -
