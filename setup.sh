#!/bin/bash

# Directory where dotfiles are stored
DOTFILES_DIR=~/dotfiles

# Loop through each file in the directory
for FILE in "$DOTFILES_DIR"/.*; do
    # Ignore . and .. entries
    [ -f "$FILE" ] || continue
    # Get the basename of each file (e.g., .vimrc)
    BASENAME=$(basename "$FILE")
    # Create the symlink in the home directory
    ln -sf "$FILE" ~/"$BASENAME"
    echo "Linked $FILE to ~/$BASENAME"
done

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
