#!/bin/bash
#______           _             
#|  _  \         | |            
#| | | |___ _ __ | | ___  _   _ 
#| | | / _ \ '_ \| |/ _ \| | | |
#| |/ /  __/ |_) | | (_) | |_| |
#|___/ \___| .__/|_|\___/ \__, |
#          | |             __/ |
#          |_|            |___/ 

# Setting Variables
cowsay "Deploy Hugo"
echo "Setting Variables and killing Hugo..."
USER=nmaximo7
HOST=91.146.103.142
DIR=httpdocs/  # the directory where your web site files should go

echo "Killing Hugo"
pkill hugo
# pkill hugo stop any running Hugo server instance. 
# This ensures no conflicts if a Hugo server was running in the background.

# Deploying Hugo.
# Cleaning the Public Directory and Building the Site
rm -rf ./public 
# It forces deletion without prompting. It removes the existing public directory, ensuring a clean slate before building.

cd /home/nmaximo7/justtothepoint/
hugo --gc --cleanDestinationDir --baseURL "https://justtothepoint.com/"
# Using --gc (Garbage Collection) is a good practice. It cleans up unused cache files and other artifacts, ensuring that the final output is as clean as possible.
# The --cleanDestinationDir option cleans the public directory before building. It prevents outdated files from lingering and causing conflicts.
# It is redundant because whe have already removed the public directory, but having both is not harmful.
# Setting the baseURL ensures that all links and references in my site’s final build point to my production domain.
# This will produce a fresh, final set of static files ready to be uploaded to my hosting environment.
# The hugo command builds the static site but does not start a server at http://localhost:1313.

# Deploying the Site
echo "Deploying the site..."
rsync --compress --recursive --verbose --checksum --delete -e 'ssh -p 2222' --delete public/ ${USER}@${HOST}:~/${DIR}

# rsync only transfers changed files and ensures your remote directory matches local exactly, thanks to --delete.
# --compress helps reduce bandwidth usage, --checksum ensures a reliable and minimal upload when files haven't changed by content.
# Using a non-standard SSH port -p 2222 is a good security measure.
# Ensuring public/ goes to ~/${DIR} on the remote host is standard practice.
