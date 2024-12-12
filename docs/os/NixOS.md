# Boot Fails
Step 1. **Create a NixOS Live USB**
Step 2. **Boot from the NixOS Live USB**
Step 3. **Identify Your Root Partition**: sudo fdisk -l.
This command lists all disk partitions. You'll need to identify the correct root partition (e.g., `/dev/nvme0n1p1`) where your NixOS installation resides.
Step 4. **Create a mount point**: sudo mkdir /mnt
This command creates a directory at `/mnt` where you will mount your root partition.
Step 5. **Mount the root partition**: sudo mount /dev/nvme0n1p1 /mnt
Mounting the root partition allows you to access your system's files and configurations.
Step 6. Mount essential virtual filesystems:
sudo mount --bind /dev /mnt/dev
sudo mount --bind /dev/pts /mnt/dev/pts
sudo mount --bind /proc /mnt/proc
sudo mount --bind /run /mnt/run
sudo mount --bind /sys /mnt/sys
These commands mount essential virtual filesystems that are necessary for the chroot environment to function correctly.
Step 7. **Chroot into Your System**: sudo chroot /mnt /nix/store/*-bash-*/bin/bash --login
The `chroot` command changes the root directory to `/mnt`, effectively allowing you to run commands as if you were booted into your installed system. Specifying the path to `bash` from the Nix store ensures you use the correct shell in the NixOS environment.

Step 8. **Fix the Bootloader**: nixos-rebuild boot
This command rebuilds the bootloader configuration.
Step 9. **Exit the chroot environment**: exit
Step 10: **Unmount filesystems**: 
    
    bash
    sudo umount /mnt/dev
    sudo umount /mnt/dev/pts 
    sudo umount /mnt/proc 
    sudo umount /mnt/run
    sudo umount /mnt/sys
    sudo umount /mnt/boot 
    sudo umount /mnt
    
Step 11: **Reboot the system**: `sudo reboot`


## **Use NixOS' System Rollback Feature**

NixOS keeps generations of system configurations, allowing you to roll back to a previous working configuration.

**Step 1: Access GRUB Menu**

During boot, pressing and holding the `Shift` key displays the GRUB menu, allowing you to choose between different boot options.

**Step 2: Select a Previous Generation**
Navigate to `NixOS - Bootable generations` and choose an earlier generation. This is useful if the current configuration is causing boot failures.

**Step 3: Boot into the Selected Generation**. Press `Enter` to boot.

**Step 4: Make the Previous Generation the Default**

Once booted, 
1. **List generations**:
 
    `sudo nix-env --list-generations --profile /nix/var/nix/profiles/system`
    This lists all available generations of your system configuration, allowing you to see which ones are available for rollback.
    
2. **Switch to the desired generation**:
    
    `sudo nix-env --switch-generation X --profile /nix/var/nix/profiles/system`
    
    Replace `X` with the generation number you want to switch to. This effectively sets the chosen generation as your current configuration.
3. **Rebuild the system to update the bootloader**:
    
    `sudo nixos-rebuild boot`
    After switching generations, this command updates the bootloader to reflect the new default configuration, ensuring that the system boots with the selected generation next time.

# Aliases
 shellAliases = {
      ll = "exa -a --icons";
      tree = "exa --tree --icons";
      gs = "git status";
      reload = "source ~/.zshrc";
      cat = "bat --paging=never --style=plain";
      #bracket = "echo \(\)\[\]~ @\|{} && copyq copy '()[]~@\|' && copyq clipboard";
      df = "df -h";  # df reports file system disk usage with human-readable sizes.
      free= "free -m"; # free displays the total amount of free and used memory in the system in MB
      webserver = "/nix/store/v6waz0jv3vavhyraf88h5h1x7b0lpv3g-myStartup/bin/myStartup";
      imageConverter = "/nix/store/3ppzkbmiq3k706jbsx766990ga1fjjxy-image-converter/bin/image-converter";
    };

# Backup 
sudo mkdir -p /mnt/mydisk (Disco interno)
/software/nix8/

```bash
borg init --encryption=none /run/media/nmaximo7/mydisk2/nixos_backups
# It sets up the repository where backups will be stored...
```

# Flatpak

```bash
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak uninstall com.ktechpit.whatsie
flatpak list

flatpak install -y flathub com.google.Chrome md.obsidian.Obsidian org.flameshot.Flameshot org.keepassxc.KeePassXC com.github.tchx84.Flatseal com.spotify.Client com.discordapp.Discord org.telegram.desktop org.libreoffice.LibreOffice flathub org.gnome.Boxes org.gimp.GIMP org.filezillaproject.Filezilla flathub org.videolan.VLC org.gnome.gedit com.anydesk.Anydesk flathub org.ferdium.Ferdium org.geany.Geany

```

# Distrobox

  /software/archlinux2/, 

``` bash
cd dotfiles/distrobox
docker build -t custom-arch .
distrobox rm arch -f
# sudo mkdir -p /home/arch-distro
# sudo chown nmaximo7:users /home/arch-distro
distrobox create --image custom-arch --name arch --home /home/arch-distro --volume /etc/static/profiles/per-user:/etc/profiles/per-user:ro --verbose
distrobox enter arch
bindsym $mod+F1 exec alacritty -e distrobox-enter arch (i3)
```

# Create a distrobox using distrobox.ini from the dotfiles.
distrobox assemble create ‐‐replace ‐‐file ~/dotfiles/distrobox.ini --home /home/arch-distro --volume /etc/static/profiles/per-user:/etc/profiles/per-user:ro --verbose
# Headless container 
distrobox enter arch ‐‐ sudo sh -c ’echo “nmaximo7 ALL=(ALL) NOPASSWD: ALL” » /etc/sudoers'
```

# Espanso

You need to register it:

_espanso service register_

# Python
nix-shell
# Hugo

FTP: Host: 91.146.103.142, User: nmaximo7, Password: MasterPass

SSH (not necessary). User: nmaximo7. Password: MasterPass

ssh nmaximo7@lin142.loading.es -p 2222 / ssh nmaximo7@91.146.103.142 -p 2222

  1. Generate Keys: ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
  2. Copy and paste from cat .ssh/id_rsa.pub (local) to .ssh/authorized_keys in the server (one possibility is access via FileZilla, download the file, update it with the new key, then upload it to the server)

vim .ssh/authorized_keys

ssh-rsa AAAAB..............................................ADD MY PUBLIC KEY

..............................................................................................== nmaximo7@nixos

  

ssh nmaximo7@lin142.loading.es -p 2222

# Linkinator 

/software/nix8/

```bash
# Initialize npm in your project directory
cd /home/nmaximo7/justtothepoint # This creates a package.json file, initializing your project as an npm project.

# Install Linkinator as a development dependency
npm install --save-dev linkinator
```
  
# The system is in BIOS mode

``` bash

[ -d /sys/firmware/efi ] && echo "UEFI mode" || echo "

"

```


/software/nix/

``` bash
boot.loader = {

grub = {

enable = true; # Activates the GRUB boot loader.

device = "/dev/nvme0n1"; # It indicates that GRUB should be installed on the entire disk (i.e., not just a partition like /dev/nvme0n1p1).

};

# Disable systemd-boot to prevent conflicts between GRUB and systemd-boot

systemd-boot.enable = false;
```

# Update channels to the same version (/software/nix3/)

Home Manager (~/dotfiles/home.nix: home.stateVersion = "24.05";) and NixOS (sudo vim /etc/nixos/configuration.nix/: system.stateVersion = "24.05"; # Did you read the comment?) need to share the same version.

``` bash
sudo nix-channel --remove home-manager 
sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
sudo nix-channel --update
[nix-shell:~/dotfiles]$ sudo nix-channel --list
home-manager https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz
nixos https://nixos.org/channels/nixos-24.05
```

# Scripts (/software/nix9/)

Location: /dotfiles/scripts. We only need to make it executable, chmod a +x and run it:
This is a building script. It will handle both instantiation and building while ensuring the derivation is protected from garbage collection.

``` bash
✦ ❯ sudo sh ./build_and_run_myStartup.sh
Derivation path: /nix/var/nix/gcroots/auto/myStartup.drv
Result path: /nix/store/v6waz0jv3vavhyraf88h5h1x7b0lpv3g-myStartup
```

Then, go to /dotfiles/zsh.nix and create an alias:
```bash
{ config, pkgs, ... }:

let
  username = config.home.username;
  dotDir = "/home/${username}/dotfiles";
in

{
  programs.zsh = {
    enable = true;

    [...]

    shellAliases = {
      webserver = "/nix/store/v6waz0jv3vavhyraf88h5h1x7b0lpv3g-myStartup/bin/myStartup";
      [... add other aliases ...]
    };
  };
}
```