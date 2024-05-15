#!/bin/bash

# Update package list and upgrade packages
sudo apt-get update
sudo apt-get dist-upgrade -y

# Download LarissaBlockchain Core
wget https://github.com/LarissaBlockchain/Core/releases/download/v1.12.0/geth-ubuntu-x86_64

# Ask for the key
read -p "Enter your LarissaBlockchain key: " larissa_key

# Create and edit the script to run Geth node
cat <<EOF > runnode.sh
#!/bin/bash

chmod +x geth-ubuntu-x86_64 && ./geth-ubuntu-x86_64 --larissa.node=1 -larissa.node.user.key=\"$larissa_key\"
EOF

# Make the script executable
chmod +x runnode.sh


# Add the script to cron to run at reboot with a delay
(crontab -l ; echo "@reboot sleep 60 && sh runnode.sh") | crontab -
