
#!/bin/bash

# Update and install necessary packages
apt-get update && apt-get install -y ca-certificates

# Download Geth binary
wget https://github.com/LarissaBlockchain/Core/releases/download/v1.12.0/geth-ubuntu-x86_64

# Create the config.toml
cat <<cat <<EOF > config.toml
[Node.P2P]
StaticNodes = ["enode://bf3713ec825f3382cd25f51bb9fbfa6b288eabf249b5e5045067565d7a284713d5bd37e5284208b62a514a55d276e3ebbc8660ed37373213fc85cdcdb99d1a88@188.34.163.235:30303",
"enode://82d34fca58eb25f18a577d70e0131727b3160ec153c60d25c1d38a69d7b383e017f53f06f4dde59e75829e550c08f801025fa1d006a60ad7fa261c26009b86e2@49.13.8.68:30303",
"enode://1dae6bd0f71b567bdfea8e5d74edc8fac4c97cc96851765528dfdbeba8b75c5373164f25e99c57913f20eda4e9d48d3ccebe0f6fc9cd3f0e24b31b6862a3cdba@49.13.233.220:30303",
"enode://d53172c4a070a2e6811409fcab05434c51e6b39bb912cfb9f4d2d617a0998c991af6883d1df5d73890ea8cbf7758b58947538be31ee5110a9e0397849559c538@159.69.83.1:30303"]
EOF

# Create the runnode.sh script
cat <<EOF > runnode.sh
chmod +x geth-ubuntu-x86_64  && ./geth-ubuntu-x86_64 --larissa.node=1 --config config.toml -larissa.node.user.key=
EOF

echo "File runnode.sh saved"

# Make runnode.sh executable
chmod +x runnode.sh


echo "Add to cron:"
(crontab -l ; echo "@reboot sleep 60 && sh runnode.sh") | crontab -

cat <<EOF >  monitor_process.sh
#!/bin/bash

# Define the process name
PROCESS_NAME="geth-ubuntu-x86_64"

while true; do
    # Check if the process is running
    if ! pgrep -x "$PROCESS_NAME" > /dev/null; then
        # If the process is not running, start it
        echo "Process $PROCESS_NAME is not running. Starting it..."
        # Command to start your process, replace the command with your actual command
        # Example: /path/to/your/process/executable &
        /path/to/your/process/executable &
    else
        echo "Process $PROCESS_NAME is running."
    fi
    # Sleep for 60 seconds
    sleep 60
done
EOF
chmod +x monitor_process.sh
(crontab -l ; echo "@reboot sleep 75 && monitor_process.sh") | crontab -
