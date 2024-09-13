#!/bin/bash

src="$HOME/homelab/www/projects/monster-hunter/mezelounge/pattern/Monster-Hunter-Frontier-Patterns"
dest="/usr/share/imhex/patterns"

# Loop through all items in the source directory and create symlinks in the destination directory
for item in "$src"/*; do
  ln -s "$item" "$dest"
done

echo "Symbolic links created successfully from $src to $dest"
