#!/bin/bash
#  ____             _                
# |  _ \           | |               
# | |_) | __ _  ___| | ___   _ _ __  
# |  _ < / _` |/ __| |/ / | | | '_ \ 
# | |_) | (_| | (__|   <| |_| | |_) |
# |____/ \__,_|\___|_|\_\\__,_| .__/ 
#                             | |    
#                             |_|    

set -e  # Exit on first error
# 1. Setting Variables
echo " 1. Setting Variables..."
BACKUP_DEST1="/run/media/${USER}/mydisk2"  # Destination for the first backup
BACKUP_DEST2="/run/media/${USER}/mydisk"  # Destination for the second backup

cowsay "My Backup"

# Checking if external drives are mounted before running the backup is critical. 
if ! mountpoint -q "$BACKUP_DEST1"; then
  echo "Error: $BACKUP_DEST1 is not mounted."
  exit 1
fi

if ! mountpoint -q "$BACKUP_DEST2"; then
  echo "Error: $BACKUP_DEST2 is not mounted."
  exit 1
fi

# 2. Backup using borgbackup
cd 
echo "2. Backing up using borgbackup..."

# Launch a backup script
if ! sh /home/nmaximo7/dotfiles/backup/backup_nixos.sh; then
    echo "Failed to execute the backup script."
fi

# 3. Rysync directories to mydisk2 and mydisk
# Synchronizing the contents of the justtothepoint directory from my home directory to the specified external disk (BACKUP_DEST1 and BACKUP_DEST2).
# -a is archive mode, which preserves file attributes, permissions, and timestamps.
# -v Verbosely logging the progress of the synchronization.
# --exclude avoids copying unnecessary files. This is a neat optimization, e.g., cleanDestinationDir and disableFastRender.
# --delete ensures that the backup destination mirrors the source exactly.

echo "3. Back up directories to $BACKUP_DEST1..."
rsync -av --exclude 'cleanDestinationDir' --exclude 'disableFastRender' --delete "$HOME/justtothepoint/" "$BACKUP_DEST1/justtothepoint"
rsync -av --delete "$HOME/dotfiles/" "$BACKUP_DEST1/dotfiles"
rsync -av --delete "$HOME/Dropbox/" "$BACKUP_DEST1/Dropbox"
rsync -av --delete "$HOME/wallpapers/" "$BACKUP_DEST1/wallpapers"
rsync -av --exclude '__pycache__/' --exclude '.venv/' --delete "$HOME/myNewPython/" "$BACKUP_DEST1/myNewPython"
rsync -av --delete /etc/nixos/ "$BACKUP_DEST1/nixos_config"

echo "3. Back up directories to $BACKUP_DEST2..."
rsync -av --exclude 'cleanDestinationDir' --exclude 'disableFastRender' --delete "$HOME/justtothepoint/" "$BACKUP_DEST2/justtothepoint"
rsync -av --delete "$HOME/dotfiles/" "$BACKUP_DEST2/dotfiles"
rsync -av --delete "$HOME/Dropbox/" "$BACKUP_DEST2/Dropbox"
rsync -av --delete "$HOME/wallpapers/" "$BACKUP_DEST2/wallpapers"
rsync -av --exclude '__pycache__/' --exclude '.venv/' --delete "$HOME/myNewPython/" "$BACKUP_DEST2/myNewPython"
rsync -av --delete /etc/nixos/ "$BACKUP_DEST2/nixos_config"
