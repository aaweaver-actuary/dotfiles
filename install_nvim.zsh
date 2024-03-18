#! /bin/zsh

binary_name="nvim"
binary_path="/usr/bin/${binary_name}"

nvim_version="0.9.5"
nvim_folder="nvim-linux64"
tar_ext=".tar.gz"
tar_hydrate_flag="z"
nvim_filename="${nvim_folder}${tar_ext}"
nvim_url="https://github.com/neovim/neovim/releases/download/v${nvim_version}/${nvim_folder}${tar_ext}"

save_path="${HOME}/${nvim_filename}"
extract_folder="${HOME}/${nvim_folder}"
move_path="/usr/bin/${nvim_folder}"

config_folder="${HOME}/.config/${binary_name}"

dotfiles_folder="${HOME}/dotfiles"

# Remove any previous nvim files
[ -d $extract_folder ] && rm -rf $extract_folder
[ -d $move_path ] && rm -rf $move_path
[ -f $save_path ] && rm $save_path
[ -f $binary_path ] && rm $binary_path
[ -d $dotfiles_folder ] && rm -rf $dotfiles_folder
[ -d $config_folder ] && rm -rf $config_folder
[ -d $HOME/$nvim_filename ] || rm $HOME/$nvim_filename

# Download with curl
curl -k -L $nvim_url -o $save_path

# Extract
chmod +x $save_path
tar -x${tar_hydrate_flag}f $save_path

# Move folder /usr/bin/
sudo mv ${HOME}/${nvim_folder} $move_path

# Link binary to /usr/bin/nvim
sudo ln -s "${move_path}/bin/nvim" "/usr/bin/nvim"

# Test nvim
nvim --version

# Clone dotfiles repo
cd $HOME
git clone http://github.com/aaweaver-actuary/dotfiles.git $dotfiles_folder --quiet

# Extract nvim.tar.gz to ~/.config/nvim
cd $dotfiles_folder
mkdir -p $HOME/.config
tar -xzf nvim.tar.gz -C $HOME/.config

# Run the install_node.zsh script
cd $dotfiles_folder
sudo chmod +x install_node.zsh
./install_node.zsh

# Ensure node is installed
node --version

# Run the install_python.zsh script
cd $dotfiles_folder
sudo chmod +x install_python.zsh
./install_python.zsh pynvim \
|| source ./install_python.zsh pynvim

# Delete dotfiles folder
rm -rf $dotfiles_folder

# Open nvim, run LazyInstall
nvim -c "LazyInstall" -c "qa"
