#!/usr/bin/env zsh

node_version="20.11.1"
node_folder="node-v${node_version}-linux-x64"
tar_ext=".tar.xz"
node_filename="${node_folder}${tar_ext}"
node_url="https://nodejs.org/dist/v${node_version}/${node_filename}"

save_path="${HOME}/${node_filename}"
extract_folder="${HOME}/${node_folder}"
move_path="/usr/bin/${node_folder}"

# Download with curl
curl -L $node_url -o $save_path

# Extract
chmod +x $save_path
tar -xJf $save_path

# Ensure sudo is installed
sudo apt install -y sudo \
|| sudo apk add --no-cache --no-check-certificate sudo \
|| { echo "install - loc0 - Failed to install sudo. Exiting."; exit 1; }

# Move folder /usr/bin/
sudo mv $save_path $move_path \
|| mv $save_path $move_path \
|| { echo "install - loc1 - Failed to move the folder to /usr/bin. Exiting."; exit 1; }

# Link binary to /usr/bin/node
sudo ln -s "${move_path}/bin/node" "/usr/bin/node" \
|| ln -s "${move_path}/bin/node" "/usr/bin/node" \
|| { echo "install - loc2 - Failed to link the binary to /usr/bin/node. Exiting."; exit 1; }
