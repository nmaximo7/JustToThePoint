#!/bin/sh
# Ultimate configuration file
# _  _  __  _  _  __   ___    _  _  ___  ___   __  ____  ___   
#( \( )(  )( \/ )/  \ / __)  ( )( )(  ,\(   \ (  )(_  _)(  _)  
# )  (  )(  )  (( () )\__ \   )()(  ) _/ ) ) )/__\  )(   ) _)  
#(_)\_)(__)(_/\_)\__/ (___/   \__/ (_)  (___/(_)(_)(__) (___)  

# Setting Variables
cowsay "Deploy Hugo"
echo "Backup"
USER=nmaximo7
BACKUP_DEST="/run/media/${USER}/mydisk2"

# Back up directories
echo "Back up directories to $BACKUP_DEST..."
rsync -av --exclude 'cleanDestinationDir' --exclude 'disableFastRender' --delete "$HOME/justtothepoint/" "$BACKUP_DEST/justtothepoint"
rsync -av --delete "$HOME/dotfiles/" "$BACKUP_DEST/dotfiles"
rsync -av --delete "$HOME/Dropbox/" "$BACKUP_DEST/Dropbox"
rsync -av --delete "$HOME/wallpapers/" "$BACKUP_DEST/wallpapers"
rsync -av --exclude '__pycache__/' --exclude '.venv/' --delete "$HOME/myNewPython/" "$BACKUP_DEST/myNewPython"
rsync -av --delete /etc/nixos/ "$BACKUP_DEST/nixos_config"

# Launch a backup script
if ! sh /home/nmaximo7/dotfiles/backup/backup_nixos.sh; then
    echo "Failed to execute the backup script."
fi

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

# Update the system. Rebuilds and activates the system configuration with the latest packages, making it a convenient way to keep your system up-to-date.
sudo nixos-rebuild switch --upgrade  
if ! sudo nixos-rebuild switch --upgrade; then
    echo "Failed to upgrade the system configuration."
    exit 1
fi


# Version Control: Keep your configuration files under version control to track changes and facilitate rollbacks.

cd /home/nmaximo7/dotfiles
# git status --porcelain: This command returns a list of files that have changes compared to the last commit. 
# if [ -n "$(git status --porcelain)" ]... checks if git status --porcelain produces any output. 
# If it does, this means there are changes in the working directory or the staging area that haven't been committed yet.

if [ -n "$(git status --porcelain)" ]; then
    git add .
    git commit -m "Update NixOS configuration"
    git push
else
echo "No changes to commit."
fi

# Monitor disk use
# nix-store --gc --print-dead
# df -h /nix/store
