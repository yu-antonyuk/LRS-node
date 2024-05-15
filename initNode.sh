
#!/bin/bash

# Update and install necessary packages
apt-get update && apt-get install -y ca-certificates

# Download Geth binary
wget https://github.com/LarissaBlockchain/Core/releases/download/v1.12.0/geth-ubuntu-x86_64

# Prompt the user for the value of KEY
read -p "Enter your KEY value: " KEY

# Create the runnode.sh script
cat <<EOF > runnode.sh
#!/bin/bash

# Set permissions for Geth
chmod +x geth-ubuntu-x86_64

# Run Geth with the provided \$KEY
./geth-ubuntu-x86_64 --larissa.node=1 -larissa.node.user.key=$KEY
EOF

echo "File runnode.sh saved"
# Make runnode.sh executable
chmod +x runnode.sh

echo "Add to cron:"
(crontab -l ; echo "@reboot sleep 60 && sh runnode.sh") | crontab -
