{ config, pkgs, lib, ... }:

let
  username = "nmaximo7"; # Replace with your actual username, journalctl -u home-manager-nmaximo7.service -b
  browser = "${pkgs.firefox}/bin/firefox";  # Path to the Firefox executable
  terminal = "${pkgs.kitty}/bin/kitty";     # Path to the Kitty terminal executable
  home = config.home;
  # Alternatively, use Alacritty:
  # terminal = "${pkgs.alacritty}/bin/alacritty";
  keyboardLayout = "es";      # Spanish keyboard layout
  scriptsDir = "/home/${username}/dotfiles/scripts";
  powerMenuCommand = "rofi -show power-menu -modi power-menu:rofi-power-menu";
  keybindings = import /home/${username}/dotfiles/hyperland/keybindings.nix {
    modifier = "SUPER";
    terminal = terminal;
    browser = browser;
    scriptsDir = scriptsDir;
    powerMenuCommand = powerMenuCommand;
  };
in
{

  home.file = {
  ".config/waybar/config".source = "/home/${username}/dotfiles/waybar/config";
  ".config/waybar/style.css".source = "/home/${username}/dotfiles/waybar/style.css";
};
  
  
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland = {
  	enable = true;
    };
    
    systemd.enable = true;
    package = pkgs.hyprland;

    extraConfig = let
      modifier = "SUPER";
    in ''
      monitor=DVI-I-1,1920x1080@60,auto,1
      # monitor=,highres,auto,2
     ${import /home/${username}/dotfiles/hyperland/env.nix {}} 

      exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = nm-applet --indicator
      exec-once = sleep 1 && waybar
      exec-once = sleep 1 && mako
      #exec-once = [workspace 1 silent] alacritty -e sh -c 'cowsay "Welcome master! Type inicio"; exec $SHELL'    
      
      ${import /home/${username}/dotfiles/hyperland/windowrules.nix {}}   
      
      ${import /home/${username}/dotfiles/hyperland/visual.nix {}}   
      
      ${import /home/${username}/dotfiles/hyperland/animations.nix {}}   
      
      ${import /home/${username}/dotfiles/hyperland/decorations.nix {}}   
      
      # Keybindings
      ${keybindings}

    '';
  };
}

