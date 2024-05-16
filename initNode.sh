
#!/bin/bash

# Update and install necessary packages
apt-get update && apt-get install -y ca-certificates

# Download Geth binary
wget https://github.com/LarissaBlockchain/Core/releases/download/v1.12.0/geth-ubuntu-x86_64

# Create the config.toml
cat <<cat <<EOF > config.toml
[Node.P2P]
MaxPeers = 40
StaticNodes = ["enode://bf3713ec825f3382cd25f51bb9fbfa6b288eabf249b5e5045067565d7a284713d5bd37e5284208b62a514a55d276e3ebbc8660ed37373213fc85cdcdb99d1a88@188.34.163.235:30303",
"enode://82d34fca58eb25f18a577d70e0131727b3160ec153c60d25c1d38a69d7b383e017f53f06f4dde59e75829e550c08f801025fa1d006a60ad7fa261c26009b86e2@49.13.8.68:30303",
"enode://1dae6bd0f71b567bdfea8e5d74edc8fac4c97cc96851765528dfdbeba8b75c5373164f25e99c57913f20eda4e9d48d3ccebe0f6fc9cd3f0e24b31b6862a3cdba@49.13.233.220:30303"]
EOF

# Create the runnode.sh script
cat <<EOF > runnode.sh
#!/bin/bash

chmod +x geth-ubuntu-x86_64  && ./geth-ubuntu-x86_64 --larissa.node=1 --config config.toml -larissa.node.user.key=
EOF

echo "File runnode.sh saved"

# Make runnode.sh executable
chmod +x runnode.sh


echo "Add to cron:"
(crontab -l ; echo "@reboot sleep 60 && sh runnode.sh") | crontab -

sudo nano runnode.sh
