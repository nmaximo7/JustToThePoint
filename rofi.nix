{ config, pkgs, ... }:

{
  programs.rofi = {
    	enable = true;
    	plugins = with pkgs; [
      		rofi-calc
      		rofi-emoji
      		rofi-power-menu
    	];
    	terminal = "${pkgs.alacritty}/bin/alacritty";
    	theme = "~/dotfiles/Rofi/rounded-dark";
    	extraConfig = {
  		modes = "window,drun,run,ssh,combi,emoji,calc,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu --choices=shutdown/reboot/logout/lockscreen --confirm=logout/lockscreen";
		combi-modes = "window,drun,emoji,calc";
  		calc-command = "qalc";
		calc-show-history = true;
  		emoji-command = "rofi-emoji"; # Ensure this is correctly set
  		font = "hack 20"; 		
  		
	};
   };
   
}

