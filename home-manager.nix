{ config, pkgs, ... }:
let
  username = "nmaximo7";
  dotfiles = "/home/${username}/dotfiles";
in
{
  # Enable Home Manager
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.backupFileExtension = "backup";

  home-manager.users.nmaximo7 = { pkgs, ... }:
  {
    home.stateVersion = "24.05"; # Update this to your current NixOS version

    home.username = username;
    home.homeDirectory = "/home/${username}";
    
    # Install Waybar
    home.packages = with pkgs; [
    	waybar
    # ... other packages ...
    ];
    
    # Let Home Manager install and manage itself
    programs.home-manager.enable = true;
    services.mako = {
      enable = true;
      defaultTimeout = 5000;
      extraConfig = ''
        background-color=#2e3440
        width=300
        height=110
        border-size=2
        border-color=#88c0d0
        border-radius=15
        icons=1
        max-icon-size=64
      '';
    };
    programs.git = {
  	enable = true;
  	userName = "Máximo Núñez Alarcón";
  	userEmail = "nmaximo7@gmail.com";
	extraConfig = {
    		init = {
	      		defaultBranch = "main";
	      		safe.directory = "/etc/nixos";
    		};
  	};
   };


    
    # Include other configuration files
    imports = [
      "${dotfiles}/shell.nix"
      "${dotfiles}/kitty.nix"
      "${dotfiles}/zsh/zsh.nix"
      "${dotfiles}/alacritty.nix"
      "${dotfiles}/rofi.nix"
      "${dotfiles}/vscode.nix"
      "${dotfiles}/nvim.nix"
      "${dotfiles}/hyperland/hyperland.nix"
      # Add other configuration files as needed
    ];

    # xdg.configFile."gtk-3.0/settings.ini".text = ''
    #  [Settings]
    #  gtk-font-name = Sans 26
    #  gtk-icon-theme-name = Adwaita
    #  gtk-theme-name = Adwaita
    # '';

    # Additional configurations can be placed here
      home.file.".config/espanso/match/base.yml".source = "/home/${username}/dotfiles/Espanso/base.yml";
    # home.file.".config/i3/config".source = "/home/${username}/dotfiles/i3/config";
    # home.file.".config/i3status/i3status.conf".source = "/home/${username}/dotfiles/i3/i3status.conf";
    # home.file.".config/picom/picom.conf".source = "/home/${username}/dotfiles/i3/picom.conf";
      home.file.".local/share/flatpak/overrides/global".text = ''
      [Context]
      filesystems=/run/current-system/sw/share/X11/fonts:ro;/nix/store:ro
    '';
   
    
   };
}

