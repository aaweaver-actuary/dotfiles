#! /bin/env zsh

# All args are assumed to be packages to install

python_binary_name="py"
python_binary_path="/usr/bin/${python_binary_name}"
pyenv_binary_name="pyenv"
pyenv_binary_path="/usr/bin/${pyenv_binary_name}"

python_version="3.11.8"
pyenv_folder="${HOME}/.pyenv"

# Remove any previous Python files
rm -rf $pyenv_folder || true
rm $pyenv_binary_path || true

# Ensure bash and zshell are installed
sudo apt install -y bash zsh sudo \
|| sudo apk add --no-cache --no-check-certificate bash zsh sudo \
|| apt install -y bash zsh sudo \
|| apk add --no-cache --no-check-certificate bash zsh sudo
|| { echo "install - loc0 - Failed to install bash and/or z shell. Exiting."; exit 1; }

# Install the specified version of Python and the required packages
curl -k -L https://pyenv.run | zsh || { echo "install - loc1 - Failed to install pyenv. Exiting."; exit 1; }

# Remove bash
sudo apt remove -y bash \
|| sudo apk del --no-cache bash \
|| { echo "install - loc0 - Failed to remove bash. Exiting."; exit 1; }

# Add the pyenv environment variables to the .zshrc file
echo 'export PATH="${pyenv_folder}/bin:$PATH"' >> ${HOME}/.zshrc \
|| { echo "install - loc1 - Failed to add pyenv to the .zshrc file. Exiting."; exit 1; }

# Initialize pyenv on shell startup
echo 'eval "$(pyenv init --path)"' >> ${HOME}/.zshrc \
|| { echo "install - loc2 - Failed to initialize pyenv on shell startup. Exiting."; exit 1; }

echo 'eval "$(pyenv init -)"' >> ${HOME}/.zshrc || \
{ echo "install - loc3 - Failed to initialize pyenv on shell startup. Exiting."; exit 1; }

# Reload the .zshrc file
exec zsh

# Ensure sudo is installed
sudo apt install -y sudo \
|| sudo apk add --no-cache --no-check-certificate sudo \
|| { echo "install - loc4 - Failed to install sudo. Exiting."; exit 1; }

# Make sure the pyenv binary is executable
chmod +x ${pyenv_folder}/bin/pyenv \
|| { echo "install - loc5 - Failed to make the pyenv binary executable. Exiting."; exit 1; }

# Link the pyenv binary to /usr/bin
sudo ln -s ${pyenv_folder}/bin/pyenv ${pyenv_binary_path} \
|| { echo "install - loc6 - Failed to link the pyenv binary to /usr/bin. Exiting."; exit 1; }

# Check the pyenv version
pyenv --version || \
{ echo "install - loc7 - Failed to check the pyenv version. Exiting."; exit 1; }

# Install the specified version of Python and the required packages
PYTHON_CONFIGURE_OPTS='--enable-optimizations --with-lto'
PYTHON_CFLAGS='-march=native -mtune=native'
pyenv install $python_version || \
{ echo "install - loc8 - Failed to install Python. Exiting."; exit 1; }

# Set the global version of Python
pyenv global $python_version || \
{ echo "install - loc9 - Failed to set global version of Python. Exiting."; exit 1; }

# rehash pyenv
pyenv rehash

# Link the Python binary to /usr/bin/py
ln -s $pyenv_folder/versions/$python_version/bin/python /usr/bin/$python_binary_name || \
{ echo "install - loc10 - Failed to link the Python binary to /usr/bin/py. Exiting."; exit 1; }

# Check the Python version
$python_binary_name --version || \
{ echo "install - loc11 - Failed to check the Python version. Exiting."; exit 1; }

# Install the required packages (the args to this script, if any)
$python_binary_name -m pip install --upgrade pip || \
{ echo "install - loc12 - Failed to upgrade pip. Exiting."; exit 1; }

$python_binary_name -m pip install $@ || \
{ echo "install - loc13 - Failed to install the required packages. Exiting."; exit 1; }

# Reload the .zshrc file
exec zsh

# Done