#! /bin/zsh 

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

# Move folder /usr/bin/
sudo mv $save_path $move_path

# Link binary to /usr/bin/node
sudo ln -s "${move_path}/bin/node" "/usr/bin/node"
