#!/bin/bash

# Backup source directories
SOURCES=(
  /etc/nixos
  /home/nmaximo7
  # List of directories you want to back up
)

# The location of your backup repository.
REPO="/run/media/nmaximo7/mydisk2/nixos_backups"

# A unique name for each backup, using the current date and time.
BACKUP_NAME="nixos-$(date +%Y-%m-%d-%H%M%S)"

# Exclude patterns to skip unnecessary files and directories you don't want to back up
EXCLUDES=(
  --exclude '/home/nmaximo7/.cache'
)

# Run the backup with the command borg create.
borg create -v --stats \
  "$REPO::$BACKUP_NAME" \
  "${SOURCES[@]}" \
  "${EXCLUDES[@]}"

# Prune (cleans up) old backups keeping only the last 4 weekly backups.
borg prune -v --list "$REPO" --keep-weekly=4
