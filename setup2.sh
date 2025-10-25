#!/bin/bash

- This script creates symlinks for dotfiles from a specified directory to the home directory.

Set the directory where your dotfiles are stored.

DOTFILES_DIR=~/dotfiles

# This loop iterates over all hidden files (files starting with a dot) in your dotfiles directory.
echo "Creating symlinks for general dotfiles..."
for FILE in "$DOTFILES_DIR"/.*; do
    # -- This check ensures that we only process actual files, not directories like . or ..
    [ -f "$FILE" ] || continue

    # This command extracts the filename from the full path.
    BASENAME=$(basename "$FILE")

    # This command creates a symbolic link in your home directory (~) that points to the original dotfile.
    # The -s flag creates a symbolic link.
    # The -f flag removes any existing destination file before creating the symlink.
    ln -sf "$FILE" ~/"$BASENAME"
    echo "Linked $FILE to ~/$BASENAME"
done
echo "General dotfile symlinks created."
echo ""

# This section handles the symlinking of nvim configuration files.
echo "Creating symlinks for nvim configuration..."

# -- Create the parent directory if it doesn't already exist.
mkdir -p ~/.config

# Symlink the entire nvim config directory.
#ln -sf ~/dotfiles/nvim ~/.config/nvim/ 
# -- complains and also removes the og dir

# mv ~/.config/nvim ~/.config/nvim.bak
# ln -s ~/dotfiles/nvim ~/.config/nvim

echo "Nvim configuration symlinked."


### Hardcoded cuz im too dumb rn
#ln -sf nvim/lua/"$FILE" ~/."$BASENAME"

# ### advanced example 
# #!/bin/bash
#
# # Directory where dotfiles are stored
# DOTFILES_DIR=~/dotfiles
#
# # List of dotfiles you want to symlink
# # FILES=(".vimrc" ".bashrc" ".zshrc" ".gitconfig")
# FILES=(".zshrc" ".gitconfig")
#
# # Loop through each file in the list
# for FILE in "${FILES[@]}"; do
#     # Create a symbolic link in the home directory
#     ln -sf "$DOTFILES_DIR/$FILE" ~/"$FILE"
#     echo "Linked $DOTFILES_DIR/$FILE to ~/$FILE"
# done




# simple example
## #!/bin/bash

# Directory where dotfiles are stored
# DOTFILES_DIR=~/dotfiles
#
# # Create symlinks for .vimrc and .bashrc
# ln -sf $DOTFILES_DIR/.vimrc ~/.vimrc
# ln -sf $DOTFILES_DIR/.bashrc ~/.bashrc
