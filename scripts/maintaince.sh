#!/bin/sh

# _  _  __  _  _  __   ___    _  _  ___  ___   __  ____  ___   
#( \( )(  )( \/ )/  \ / __)  ( )( )(  ,\(   \ (  )(_  _)(  _)  
# )  (  )(  )  (( () )\__ \   )()(  ) _/ ) ) )/__\  )(   ) _)  
#(_)\_)(__)(_/\_)\__/ (___/   \__/ (_)  (___/(_)(_)(__) (___)  

# This fetches the latest package lists from subscribed channels.
if ! nix-channel --update; then
    echo "Failed to update Nix channels."
    exit 1
fi
# Rebuild the system
if ! sudo nixos-rebuild switch; then
    echo "Failed to rebuild the system."
    exit 1
fi

# Update your installed Flatpak applications so you can benefit from the latest features and security updates.
if ! flatpak update; then
    echo "Failed to update Flatpak applications."
fi

# Upgrade all containers' packages
if ! distrobox-upgrade --all; then
    echo "Failed to upgrade Distrobox containers."
fi


# Update the system
sudo nixos-rebuild switch --upgrade # Rebuilds and activates the system configuration with the latest packages, making it a convenient way to keep your system up-to-date.


# Version Control: Keep your configuration files under version control to track changes and facilitate rollbacks.
cd /home/nmaximo7/dotfiles
git add .
git commit -m "Update NixOS configuration"
git push

# Monitor disk use
nix-store --gc --print-dead
df -h /nix/store
