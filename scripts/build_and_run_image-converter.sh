#!/bin/sh

# Instantiate the derivation and add a root reference
DRV_PATH=$(nix-instantiate --add-root /nix/var/nix/gcroots/auto/image-converter.drv /home/nmaximo7/dotfiles/scripts/image-converter.nix)
echo "Derivation path: $DRV_PATH"

# Build the derivation
RESULT_PATH=$(nix-build $DRV_PATH)
echo "Result path: $RESULT_PATH"
