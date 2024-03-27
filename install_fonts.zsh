#! /bin/env zsh

jetbrains_font_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip"

# Download and install JetBrains Mono font
curl -k -L ${jetbrains_font_url} -o JetBrainsMono.zip # download
unzip JetBrainsMono.zip -d JetBrainsMono # unzip
cp -r JetBrainsMono/ttf/* ~/.local/share/fonts # copy to fonts directory
fc-cache -f -v # update font cache
rm -rf JetBrainsMono JetBrainsMono.zip # clean up