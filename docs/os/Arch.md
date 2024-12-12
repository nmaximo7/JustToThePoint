Hay ficheros privados como cat .zshenv, con passwords e información privadas estan en KeyPassXC, ComputerMoviles, miPcs, Wifi, miMac, Router, Duck DNS, synching.
https://justtothepoint.com/software/archlinux/
https://justtothepoint.com/software/archlinux2/ 
https://justtothepoint.com/software/archlinux3/
**Update the system**: sudo pacman -Syu
Refreshing your keyring:  sudo pacman-key --refresh-keys

# 1. Pre-installation (it is normally not required, just type archinstall)

Set up the keyboard layout: loadkeys es: echo "KEYMAP=es" >> /etc/vconsole.conf

Verify boot mode (UEFI). If it doesn't exist you are either on old hardware or you have UEFI disabled: ls /sys/firmware/efi/efivars

Internet connection: ping -s 5 archlinux.org
If it does not work: ip link, e.g., # 2: enp5s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP mode DEFAULT group default qlen 1000
Trying to bring up the interface: ip link set dev enp5s0 up
Run dhcpd to provide DHCP service to our machine: dhcpcd enp5s0
Check again: ping -s 5 archlinux.org

Set up my timezone, enable and start network time synchronization (NTP, Network Time Protocol, it is used to synchronize the system clock between computers), and set the hardware clock from the system clock:
timedatectl set-timezone Europe/Madrid
sudo timedatectl set-ntp true+--
sudo hwclock --systohc

# 2. Partitioning
list all block level devices available on your system: lsblk 
disk=/dev/nvme0n1 **This is the disk**

Wipe out the partition table: sgdisk --zap-all $disk

Partition the drive:
sgdisk -og $disk
sgdisk -n 1:2048:+1M    -c 1:"BIOS Boot Partition"  -t 1:ef02 $disk  # 1M
sgdisk -n 2:0:+100G      -c 2:"Linux /"              -t 2:8304 $disk  # 90G
sgdisk -n 3:0:+2G       -c 3:"[SWAP]"               -t 3:8200 $disk  # 2G
sgdisk -n 4:0:0         -c 4:"Linux /home"          -t 4:8302 $disk  # ...

Format the partitions:
mkfs.vfat /dev/nvme0n1p1
mkfs.ext4 /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p4
mkswap  /dev/nvme0n1p3
swapon  /dev/nvme0n1p3

Mount the root and the EFI boot fileystem
mount /dev/nvme0n1p2 /mnt
mkdir -p /mnt/{boot/efi,home}
mount /dev/nvme0n1p1 /mnt/boot/efi
mount /dev/nvme0n1p4 /mnt/home


# MAPA DE MIS DISCOS

1. /dev/nvme0n1
	* /dev/nvme0n1p1 fat32 /boot
	* /dev/nvme0n1p2 ext4 / (my Arch)
2. /dev/sda 
	 * /dev/sda1 ext4 2.73 TiB,  Mounted on /run/media/nmaximo7/mydisk2 !!! UUID = bd753b26-a4ec-4063-8d36-5215c358ed00. Aquí estan las carpetas de timeshift y la imagen de Rescuezilla, 2024-04-03-1502-img-rescuezilla
3. /dev/sdb
	 * /dev/sdb1 ext4 1.82 TiB,  Mounted on /run/media/nmaximo7/mydisk1 !!! UUID = cb8ee0c2-6afe-4853-ae39-0cc1dce73ef0


# 3. Arch Linux installer 

Ventoy (ArchLinux.iso).
F8. Boot options.

* **Archinstall language**: SET: English.
* **Locales**: Keyboard layout, set your preferred keyboard layout, e.g., SET: _es_; Locale language, e.g., SET: en_US; Locale encoding: SET: UTF-8.
* **Bootloader**: System-boot (default). Later on, sudo vim /boot/loader/loader.conf, timeout 0
* **Unified Kernel Image**: False.
* **Mirror region**. It is asking for the region to download packages from, e.g., SET: ['Spain']. 
* **Drive**. This is where you need to select the disk where you want to install Arch, e.g., /dev/nvme0n1p1
* **Disk layout**. Select **Wipe all selected drives and use a best-effort default partition layout** (this is kind of _automatically partitioning_), then choose which filesystem your main partition should use, e.g., **ext4**. Would you like to create a separate partition for /home? Select **yes (default)**.
* **Encryption password**: SET: None. If you are using this installation in a real machine, use _disk encryption_.
* **Swap**: SET: True.
* **Hostname**. It is asking you for a hostname, e.g., SET: myArch.
* **Root password**. You should set a strong password for the admin account. Keep it safe, e.g., use KeePass (Root, miPC)
* **User account**. Create your user account (nmaximo7, password -KeePass (Root, miPCs)), and you can also choose to allow this user to be a superuser. Besides, you can create additional users.
* **Profile**. What kind of installation you would like: _desktop_, minimal, server, or xorg. Choose **desktop**, then you will be asked to select your desired desktop environment: Awesome, **i3-wm**, Gnome, etc. Next, select **i3-gaps**/i3-wm and a graphic driver, e.g., _Graphic drivers: Nvdia (propietary)_, Greeter: lighted-gtk-greeter.
* **Audio**. SET: pipewire. Decide whether you need to install the PipeWire or PulseAudio for audio support
* **Kernel**. SET: [`linux']
* **Additional packages**. SET: [`vim']. Add additional packages to be installed after the installation.
* **Network configuration**. _Use Network Manager_. It is a program for providing detection and configuration for systems to automatically connect to networks.
* **Timezone**. SET: Europe/Madrid.
* **Automatic time sync (NTP)**. It synchronizes with NTP servers to set the time automatically, SET: TRUE.
* **Additional repositories to enable**. SET: [`multilib'].
 

The installer gives you the chance to save these configurations, which is helpful if you want to use the same configuration on other systems. Finally, it's time to choose **Install**. Would you like to chroot into the newly created installation and perform post-installation configuration? Select **no**.


# 4. Post-installation (https://justtothepoint.com/software/windowmanagers2/)
* **Update the system**: sudo pacman -Syu

* **Reflector is a Python script which can retrieve the latest mirror list from the Arch Linux Mirror Status page**. It filters the most up-to-date mirrors, sorts them by speed, and overwrites the file /etc/pacman.d/mirrorlist: sudo reflector --verbose --country 'Spain' --latest 5 --sort rate --save /etc/pacman.d/mirrorlist

* Setting Pacman options:
1. sudo sed -i '/Color/s/^#//' /etc/pacman.conf
2. sudo sed -i '/Color/a ILoveCandy' /etc/pacman.conf
3. sudo sed -i "/\[multilib\]/,/Include/"'s/^#//' /etc/pacman.conf
4. yay -S powerpill (Powerpill is a package manager wrapper for Pacman, designed to improve download speeds by using parallel and segmented downloads.)
5. Automatically cleaning the package cache: sudo pacman -S pacman-contrib, sudo systemctl enable paccache.timer (https://justtothepoint.com/software/package-managers/)

   user@pc:~$ visudo, then add this line: nmaximo7 ALL=(ALL) NOPASSWD: ALL
***********************************************************************************************************************
* IR A LA SECCION DE DISTROBOX
****************************************************************************************************************
* Some packages:
1. **sudo pacman -Sy --noconfirm mlocate rsync bash-completion reflector neofetch zsh zsh-completions zsh-autosuggestions conky bat neovim**. Neovim is a modern fork of the popular text editor Vim (nvim)
2. **sudo pacman -Sy --noconfirm alacritty tumbler pcmanfm xarchiver cmatrix bat powerline cowsay zsh lolcat lsd**. Notice: lolcat is a command-line utility used to output text with rainbow colors, e.g., echo "Hello, world!" | lolcat. lsd is a ls command with a lot of pretty colours and some other stuff to enrich and enhance the directory listing experience. Remember: ln -s /usr/bin/batcat ~/.local/bin/bat
3. **sudo pacman -Sy --noconfirm stow copyq man-db wget scrot cron clamav copyq exa feh openssh**. scrot is a minimalist command-line screen capturing application, exa is a modern replacement for ls, feh is a lightweight image viewer aimed mainly at users of command line interfaces.
4. **sudo pacman -Sy --noconfirm filezilla vlc barrier keepassxc gnupg gparted unzip**. GnuPG enables you to secure your files on Windows, macOS, and Linux using state of the art cryptography.
5. **sudo pacman -S picom nitrogen greenclip copyq** 
6. **sudo pacman -Sy --noconfirm alacritty cmatrix bat powerline cowsay zsh lolcat lsd zsh zsh-completions powerline powerline-fonts** Alacritty is a modern terminal emulator that comes with sensible defaults.
7. **sudo pacman -Sy --noconfirm picom gedit pulseaudio pavucontrol rofi lxappearance nitrogen archlinux-wallpaper** pavucontrol is the PulseAudio Volume Control. Rofi is an alternative application launcher. archlinux-wallpaper are Arch Linux Wallpapers. picom is a standalone compositor for Xorg, suitable for use with window managers that do not provide compositing. lxappearance is a program to change GTK+ themes, icon themes, and fonts used by applications.

PCManFM is a fast and lightweight file manager that's full of features.

``` bash

vim .config/pcmanfm/default/pcmanfm.conf # Edit PCManFM's configuration filemarkdown_content

	[folder]
	font=Sans 12 # Modify Font Settings
```

# 5. Install Yay, Dropbox, Google Chrome.

The Arch User Repository (AUR) is a community-driven repository for Arch users. It contains package descriptions (PKGBUILDs) that allow you to compile a package from source with makepkg and then install it via pacman. 
First, we clone the project:

git clone https://aur.archlinux.org/yay.git
cd yay # And we move to its directory.

Second, we build the package and install it.
makepkg -si
cd ..
rm -rf yay

yay -S dropbox dropbox-cli google-chrome

# 6. Repositories 

Git. First-Time git setup. Set your user name and email address:

```
git config --global user.name "Maximo Nunez"
git config --global user.email nmaximo7@gmail.com

```
Configure SSH on an Arch Linux: sudo pacman -Sy openssh gnupg

Generate two SSH (ed25519 and an RSA) key-pairs:

```
ssh-keygen -o -a 100 -t ed25519 -f ~/.ssh/id_ed25519 -C "nmaximo7@gmail.com"
ssh-keygen -t rsa -b 4096 -C "nmaximo7@gmail.com"

```
Add Your newly generated Ed25519 key to the SSH Agent (first, make fure that the SSH agent is running by executing:): eval "$(ssh-agent -s)"

... you can find your newly generated private key at ~/.ssh/id_ed25519 and your public key at ~/.ssh/id_ed25519.pub
ssh-add ~/.ssh/id_ed25519

Note: An SSH agent is a program that manages SSH keys for secure authentication. It holds the private keys associated with SSH public key authentication, allowing users to authenticate to remote servers without entering their passphrase every time.

Copy the public key to your GitHub account. Log in to your GitHub account, click on your profile icon in the top-right corner and select "Settings". In the left sidebar, click on "SSH and GPG keys.", click on the "New SSH key" button, give your SSH key a title (e.g., "myArch"), paste your public key into the "Key" field, click "Add SSH key" to save.

```
cat ~/.ssh/id_ed25519.pub 

# Let's allow authentication to the computer using our key by addingour public key to the list of allowed keys (~/.ssh/authorized_keys):
cat ~/.ssh/id_ed25519.pub > ~/.ssh/authorized_keys  
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

```
**Migration to new computer**

```
cd ~
git clone https://github.com/nmaximo7/dotfiles.git (you will need to provide your token: Keepass, github)

# If you want to clone a Git repository from GitHub while indicating your personal access token (token) for authentication, you can use the following syntax:

git clone https://<username>:<token>@github.com/<owner>/<repository>.git

```
Replace <username> with your GitHub username, <token> with your personal access token, <owner> with the repository owner's username or organization name, and <repository> with the name of the repository you want to clone, e.g., git clone https://nmaximo7:myToken@github.com/nmaximo7/dotfiles.git (Keepass, github)

Let’s stow the files and directories into their target directories. First, check that it is working as expected: stow --adopt -nvSt ~ *

then, do it (https://justtothepoint.com/software/advanced-servers/, Dotfiles with Git + GNU Stow): stow --adopt -vSt ~ *

You need a token and enter it instead of your password when performing Git operations over HTTPS. There is a cool mechanism in Git to avoid having to type your password over and over again:  git config ‐‐global credential.helper store

# 7. Configure LightDM autologin

sudo vim /etc/lightdm/lightdm.conf

[Seat:*]
autologin-user=<your_username>
autologin-session=i3

I didn't need it, but you may need to set permissions for LightDM's configuration file (sudo chmod 644 /etc/lightdm/lightdm.conf), and restart LightDM (sudo systemctl restart lightdm)

sudo vim /home/nmaximo7/.config/i3/config:

exec --no-startup-id /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

exec --no-startup-id /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1

# 8. Install some fonts.

https://justtothepoint.com/softwarees/archlinux3/

```
yay -Ss <font-name> # Search for the font package
# Install the font package: (yay -S <font-package>)
yay -S aur/ttf-meslo-nerd-font-powerlevel10k
# Enable the font: After installation, you may need to update your font cache so that the system recognizes the newly installed font. 
fc-cache -vf 

sudo pacman -Sy --noconfirm noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-hack ttf-roboto
sudo pacman -Sy --noconfirm ttf-ubuntu-font-family ttf-dejavu ttf-freefont ttf-liberation ttf-droid terminus-font ttf-font-awesome 
mkdir -p ~/.local/share/fonts \
cd ~/.local/share/fonts \
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hermit.zip \
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip \ 
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip \
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SourceCodePro.zip \
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/DejaVuSansMono.zip \
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip \
unzip Hermit.zip && unzip Hack.zip && unzip DejaVuSansMono.zip && unzip FiraCode.zip && unzip SourceCodePro.zip && unzip Meslo.zip \
rm *.zip && fc-cache -fv
	
```

# 9. Espanso and Neovim. 

Neovim (https://justtothepoint.com/softwarees/editores-de-textos-minimalistas/)
```bash
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

nvim .config/nvim/init.vim, then type :PlugInstall

https://justtothepoint.com/software/espanso/
First option:
* Install FUSE package: sudo pacman -S fuse2
* Load the FUSE kernel module. You may need to ensure that the FUSE kernel module is loaded, sudo modprobe fuse2.
* Enable FUSE in systemd: sudo systemctl enable fuse2
* Check AppImage permissions: 
* Install Espanso: yay -S espanso.
* Start Espanso: espanso start
* To start Espanso automatically on boot, you can enable its systemd service: sudo systemctl enable espanso 

Second options:
Create the $HOME/opt destination folder: mkdir -p ~/opt
# Download the AppImage inside it
wget -O ~/opt/Espanso.AppImage 'https://github.com/federico-terzi/espanso/releases/download/v2.2.1/Espanso-X11.AppImage'
# Make it executable
chmod u+x ~/opt/Espanso.AppImage
# Create the "espanso" command alias
sudo ~/opt/Espanso.AppImage env-path register

From now on, you should have the espanso command available in the terminal (you can verify by running espanso --version).

# Register espanso as a systemd service (required only once)
espanso service register

# Start espanso
espanso start

Third option:
sudo pacman -S --needed git base-devel && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

**Sincronization Dropbox**
cd .config/espanso/match/
mv base.yml base.yml.bak
ln -s /home/nmaximo7/Dropbox/espanso/default.yml base.yml

(If you make a mistake, use unlink to remove symbolic links)

espanso install actually-all-emojis
# Since version 0.7.0, espanso introduced a few gui-related features that require modulo to be installed in your system.
# It is not strictly required, but it's highly suggested to install it.
git clone https://aur.archlinux.org/modulo.git
cd modulo
makepkg -si
cd ..
rm -rf modulo
espanso restart

_espanso-edit_. allows quick modifying of espanso matches through a visual editor activited through shortcuts. After every configuration change, espanso must be restarted: _espanso restart_.

10. Hugo. https://justtothepoint.com/code/hugo/
* Install Hugo: sudo pacman -Syu go hugo
* Verify installation: hugo version
* Copy your site directory and navigate to your site directory: cd /path/to/your/site
* Run Hugo commands: With Hugo reinstalled, you can continue working with your existing site as before. You can use commands like **hugo server to run a local development server**, hugo new to create new content, and hugo build to generate your site.
* Publish your site. Once you're satisfied with the changes, you can generate the static files for your site by running: hugo. This will generate the static HTML files in the public directory of your site.
* Upload your site. If you're hosting your site online, you may need to upload the contents of the public directory to your web server. 

I need to open a ssh connection, ssh nmaximo7@lin142.loading.es -p 2222 (Entry Loading: Plesk, _Password Main_) and copy and paste the password from .ssh/id_rsa.pub (local, cat .ssh/id_rsa.pub) to .ssh/authorized_keys (vim .ssh/authorized_keys).

11. Hugo, https://justtothepoint.com/code/hugo/
I tested but it does not seem to be needed (https://gohugo.io/content-management/mathematics/#inline-delimiters)
LaTeX: https://justtothepoint.com/maths/libreoffice-math-and-latex/

```bash
	sudo pacman -S nodejs npm
	rm -rf node_modules
	npm install
	npm audit fix --force # To address all issues (including breaking changes)
```

Broken Links: (https://justtothepoint.com/code/hugo5/)
```bash
	wget --spider -r -w 1 -o ~/wget.log https://justtothepoint.com/
	grep -B2 '404 Not Found' ~/wget.log
```

Note: mysearch "nameFileNotFound"

13. Wallpapers, Picom.
git clone https://gitlab.com/dwt1/wallpapers.git ~/Pictures/wallpapers

cp /etc/xdg/picom.con ~/.config/picom/picom.conf

vim .config/i3/config
exec --no-startup-id picom --config ~/.config/picom/picom.conf
exec_always nitrogen --set-zoom-fill --random ~/Pictures/wallpapers

13. Barrier.

vim .config/i3/config

exec /usr/bin/barrierc -f --no-tray --debug INFO [192.168.1.50]:24800 &

14. Python
https://justtothepoint.com/software/python/
https://justtothepoint.com/managingconfigurationpython-dotenv/ (Create a new Python project & Migrating)
https://justtothepoint.com/code/batteries-included-virtual-environments/

cd
git clone https://aur.archlinux.org/visual-studio-code-bin.git
cd visual-studio-code-bin
makepkg -si
cd ..
rm -rf visual-studio-code-bin

yay --noconfirm -S code
# Python extensions, https://itsfoss.com/install-vs-code-extensions/

code --install-extension ms-python.python
code --install-extension oderwat.indent-rainbow
code --install-extension pkief.material-icon-theme 
code --install-extension eg2.vscode-npm-script
code --install-extension streetsidesoftware.code-spell-checker
code --install-extension streetsidesoftware.code-spell-checker-spanish


yay -S consolas-font
# Tell Visual studio code which Python version to use: Ctrl + Shift + P, Python: Select Interpreter.
# Activate a virtual environment: source /home/nmaximo7/Dropbox/myPython/venv/bin/activate. To deactivate it: deactivate.
# Error: VSCode: There is no Pip installer available in the selected environment. Solution: Edit ./venv/pyvenv.cfg:
# include-system-site-packages = true. Python files will now go to the virtual environment and the system packages are visible, too.
# Change your user settings: Open the Command Palette (Ctrl+Shift+P) and type: Preference: Open Settings (JSON)</strong> (File, Preferences, Settings),
# e.g., "editor.fontFamily": "Consolas", // It controls the font family

# 15. ZSH

sudo pacman -S zsh zsh-completions powerline powerline-fonts
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sudo pacman -Sy fortune-mod

Clone the Powerlevel10k repository to your Oh My Zsh themes directory: git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k


# zsh-autosuggestions. Fish-like fast/unobtrusive autosuggestions for zsh.
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# zsh-syntax-highlighting. It provides syntax highlighting for the shell zsh.
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# Powerlevel10k is a theme for Zsh. It emphasizes speed, flexibility and out-of-the-box experience.
# Set ZSH_THEME="powerlevel10k/powerlevel10k" in ~/.zshrc.
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# Prints out an ASCII picture of a cow saying a random epigram on every zsh start.
git clone https://github.com/babasbot/auto-fortune-cowsay-zsh $ZSH/custom/plugins/auto-fortune-cowsay
# zsh-completions aims at gathering/developing new completion scripts that are not available in Zsh yet
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions

# fzf is a general-purpose command-line fuzzy finder.
git clone --depth 1 git@github.com:junegunn/fzf.git ~/.fzf
~/.fzf/install

# https://github.com/hkbakke/bash-insulter, Bash-insulter randomly insults you when you type a wrong command.
git clone https://github.com/hkbakke/bash-insulter.git bash-insulter
sudo cp bash-insulter/src/bash.command-not-found /etc/

nvim /home/nmaximo7/.zshrc

if [ -f /etc/bash.command-not-found ]; then
    . /etc/bash.command-not-found
fi

For security reasons (APY_KEYS) the file ~/.zshenv is not in the GIT repository (the  lines are in KeePassXC, miPcs, Wifi, miMac, Router, Duck DNS, synching)

16.  Quotes. 
.zsh_aliases: alias fortune='fortune ~/myPython/assets/fortunes'

Adding your quotes. The format needs to be as follows:
# You cannot achieve the impossible without attempting the absurd.
# %

cd /home/nmaximo7/myPython/assets/
strfile fortunes

17. Security
sudo pacman -S syncthing (https://justtothepoint.com/software/backup/, https://www.youtube.com/watch?v=Uag8PJaO0N4)
# Start the synchronization service
sudo systemctl start syncthing@nmaximo7.service
# Autostart enable
sudo systemctl enable syncthing@nmaximo7.service
# Configuration through browser GUI, simply visit 127.0.0.1:8384 
No Allow Anonymous Usage Reporting. Set User/Password (only mac, http://127.0.0.1:50542 -key pass- miPC)
# Remote Web GUI
# vi /home/nmaximo7/.config/syncthing/config.xml
# And change the GUI Listen Address setting from the default 127.0.0.1:8384 to 0.0.0.0:8384.

(Linux) Add Remote Device.  Add Path ··· Folder Path: ~/justtothepoint. Sharing: myMac. Send Only.
(Mac) Add Folder: /Volumes/Principal/justtothepoint/website/

(Linux) Add Remote Device.  Add Path ··· Folder Path: ~/Dropbox. Sharing: myMac. Send Only.
(Mac) Add Folder: /Volumes/Principal/justtothepoint/DropboxBackup/

# Firewall (synching)
# Firewalld is a firewall that uses nftables by default.
# https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/using-and-configuring-firewalld_configuring-and-managing-networking
# Install necessary packages
sudo pacman -S firewalld ipset ebtables
# Enable and start firewalld.service.
sudo systemctl enable --now firewalld.service
# Change the default zone to home.
sudo firewall-cmd --set-default-zone=home
# Open ftp and htpp services: --permanent because changes made in Runtime configuration
# are lost when the firewalld service is restarted, e.g., sudo firewall-cmd --add-service=ftp --permanent
sudo firewall-cmd --add-service=http --permanent
Rescuezilla, Boot in normal mode, instead of Start Rescuezilla, I need to select Graphical fallback mode. 
sudo firewall-cmd --add-port=1313/tcp --permanent
# Allow traffic on an incoming port (24800) -Barrier-
sudo firewall-cmd --add-port=24800/tcp --permanent
# Restart the firewall.
sudo firewall-cmd --reload
# List allowed service and ports on the system
sudo firewall-cmd --list-service

# Stop FirewallD Service, https://www.tecmint.com/start-stop-disable-enable-firewalld-iptables-firewall/
systemctl stop firewalld

# Check the Status of FirewallD
systemctl status firewalld

# Firewall-synching (PostInstallfirewall)
sudo firewall-cmd --zone=public --add-service=syncthing --permanent
sudo firewall-cmd --zone=public --add-service=syncthing-gui --permanent
sudo firewall-cmd --reload

18. Distrobox (https://justtothepoint.com/software/docker/)

sudo pacman -S distrobox podman # If you have used Arch Linux, then you definitely know how easy it is to mess up your system. With containerized systems, you can create each one for a specific task. **Distrobox** allows you to create and manage containers on your favorite Linux distribution using either Docker or **Podman**.
sudo pacman -S xorg-xhost

vim .zshrc: xhost +si:localuser:$USER
You may have an error, "Cannot open display," indicates that GIMP is unable to access the X server display. This issue typically arises when there's a problem with X11 forwarding or permissions to access the X server.

Editing the `.zshrc` file to include the command `xhost +si:localuser:$USER` allows your user to access the X server using the xhost utility (sudo pacman -S xorg-xhost). 

The  xhost program is used to add and delete host names or user names to the list allowed to make connections to the X  server. This command grants permission to the current user to connect to the X server: 
xhost +si:localuser:$USE # 1) xhost + 2) with local user authorization `si:localuser:$USER`

distrobox create -i archlinux # Create a Container from an Image
distrobox enter archlinux # Accessing a Distrobox Container, distrobox-enter --name container-name
sudo pacman -S vlc flameshot neofetch
sudo pacman -Syu gimp
sudo pacman -S libcanberra-pulse # `a library that allows applications to play event sounds through the PulseAudio sound server by providing support for PulseAudio

# You may want to directly run the commands on a Distrobox container instead of accessing the container: distrobox-enter --name container-name  -- command, e.g., distrobox-enter --name archlinux  -- gimp
# Stop an image: distrobox stop archlinux 
# Clone an image: distrobox create --name arch2--clone archlinux 
# Remove an image: distrobox rm arch2 
# List Images: distrobox-list 
# Upgrade all images: distrobox upgrade --all
# Exporting Applications from Container to Host. Access the container’s shell, then distrobox-export --app name_app, e.g., distrobox-export --app vlc 

19. Troubleshooting
Errors indicating that keys cannot be verified. Clone a Git Repository. Git, fatal: The remote end hung up unexpectedly. Forget password. Mount drives. No bootable device. Recover from a snapshot using Timeshift (https://justtothepoint.com/software/troubleshooting2/)

* Forget password: sudo passwd root (easy way, difficult way: https://justtothepoint.com/software/troubleshooting2/)

* How To Remove GIT History And Make Your Repo Smaller (https://justtothepoint.com/software/advanced-servers/, https://www.youtube.com/watch?v=2yeM0v4tYpw&ab_channel=Code%2CTech%2CandTutorials)

# How To Clean Up And Reduce The Size Of A Git Repository (https://justtothepoint.com/software/troubleshooting2/)
git checkout --orphan abranchnane # Start a new branch from scratch without any previous commit history.
git add -A # Stage all changes in the working directory for the next commit.
git commit -am "Fresh start"
git branch -D main # The `git branch -D main` command is used to forcefully delete the specified branch named "main" in Git.
git branch -m main # Rename the current branch to "main" in Git. 
git push -f origin main # It pushes the renamed branch ("main") to the remote repository and sets it as the upstream branch.
git gc --aggressive --prune all # It performs garbage collection, which cleans up unnecessary files and optimizes the repository for better performance. --aggressive runs a more aggressive garbage collection 


* How to mount drives

sudo mkdir -p /run/media/nmaximo7/mydisk1 # Create directories for mounting the partitions.
sudo mkdir -p /run/media/nmaximo7/mydisk2

``` bash
	blkid # Identify the drives and their partitions.
		/dev/nvme0n1p1: UUID="6D37-71F1" BLOCK_SIZE="512" TYPE="vfat" PARTUUID="3fbc4526-c0ae-475b-b775-a503c5394eca"
		/dev/nvme0n1p2: UUID="f28469fa-378e-4548-b646-3af8542ddaab" BLOCK_SIZE="4096" TYPE="ext4" PARTUUID="68bdbf55-5b11-4644-ae88-59dac470188a"
		/dev/sda1: UUID="bd753b26-a4ec-4063-8d36-5215c358ed00" BLOCK_SIZE="4096" TYPE="ext4" PARTLABEL="mydisk" PARTUUID="8c3029bc-0bfa-4dc0-a80b-a0dadbca6e42"
		/dev/sdb1: LABEL="mydisk2" UUID="cb8ee0c2-6afe-4853-ae39-0cc1dce73ef0" BLOCK_SIZE="4096" TYPE="ext4" PARTLABEL="Elements" PARTUUID="857f50ed-94ef-4b8a-aeee-574443340c4b"
```
sudo nvim /etc/fstab
``` bash
	UUID=cb8ee0c2-6afe-4853-ae39-0cc1dce73ef0   /run/media/nmaximo7/mydisk1   ext4   defaults   0   2
	UUID=bd753b26-a4ec-4063-8d36-5215c358ed00   /run/media/nmaximo7/mydisk2   ext4   defaults   0   2
```

``` bash
	sudo chown -R nmaximo7:nmaximo7 /run/media/nmaximo7/mydisk2 # It recursively change the ownership of all files and directories under `/run/media/nmaximo7/mydisk2` to the user and group `nmaximo7`; the `-R` option applies the change recursively.
	sudo mount -a # Read the /etc/fstab configuration file and mount all entries in `/etc/fstab`.
	systemctl daemon-reload # Reload the systemd daemon to apply the changes.
```


sh: ./.local/bin/linkchecker: No such file or directory

https://wiki.hyprland.org/Getting-Started/Master-Tutorial/

20. BACKUP

My  home folder is in: /run/media/nmaximo7/mydisk1/myLinux/ 

* Timeshift is an application similar to the Time Machine tool in Mac OS, **https://justtothepoint.com/software/virtualization2/**, https://justtothepoint.com/software/backup2/, https://justtothepoint.com/software/troubleshooting2/

RECOVER: Ventoy (Linux Mint comes with timeshift installed in the ISO), **timeshift-gtk**.

# It protects your system by taking incremental snapshots of the file system at regular intervals.
git clone https://aur.archlinux.org/timeshift.git
cd timeshift
makepkg -si
cd ..
rm -rf timeshift
# 1. Launch it: sudo timeshift-gtk. 2. Snapshot Type: RSYNC (Snapshots are incremental).
# 3. Select Snapshot Location where your snapshots will be saved, e.g., sda1.
# 4. Select Snapshot Levels. It sets an automatic backup schedule, e.g., daily and 2 as the numbers of snapshots to be saved.
# 5. User Home Directories. User data is excluded by default, but you can change this: Include All.

* Rescuezilla (https://justtothepoint.com/software/cloning/). F8. Rescuezilla, Boot in normal mode, instead of Start Rescuezilla, I need to select **Graphical fallback mode.** 

21. AI. 
https://justtothepoint.com/code/ai/
