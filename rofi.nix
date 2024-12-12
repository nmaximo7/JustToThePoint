{ config, pkgs, ... }:

{
  programs.rofi = {
    	enable = true;
    	plugins = with pkgs; [
      		rofi-calc
      		rofi-power-menu
    	];
    	terminal = "${pkgs.alacritty}/bin/alacritty";
    	extraConfig = {
    		modes = "window,drun,run,ssh,combi,power-menu:${pkgs.rofi-power-menu}/bin/rofi-power-menu -choices=shutdown/reboot/logout/lockscreen";
    		combi-modes = "window,drun";
    		calc-command = "qalc";
    		calc-show-history = true;
    		font = "hack 20"; # Adjust the font and size as needed
  	};
   };
}

