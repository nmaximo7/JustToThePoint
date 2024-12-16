{ config, pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      scrolling = {
        history = 1000;
      };
      window = {
        dynamic_title = true;
        opacity = 0.9;
        padding = {
          x = 20;
          y = 20;
        };
        dimensions = {
          columns = 80;
          lines = 24;
        };
      };
      env = {
  	WINIT_X11_SCALE_FACTOR = "1.0";
      };
      font = {
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
        size = 18;
      };
      colors = {
        # Default colors
        primary = {
          background = "0x282a36";
          foreground = "0xf8f8f2";
        };
        # Normal colors
        normal = {
          black =   "0x000000";
          red =     "0xff5555";
          green =   "0x50fa7b";
          yellow =  "0xf1fa8c";
          blue =    "0xbd93f9";
          magenta = "0xff79c6";
          cyan =    "0x8be9fd";
          white =   "0xbbbbbb";
        };
        # Bright colors
        bright = {
          black =   "0x555555";
          red =     "0xff5555";
          green =   "0x50fa7b";
          yellow =  "0xf1fa8c";
          blue =    "0xcaa9fa";
          magenta = "0xff79c6";
          cyan =    "0x8be9fd";
          white =   "0xffffff";
        };
      };
      selection = { 
      		semantic_escape_chars = ",?`|:\"' ()[]{}<>"; 
      		save_to_clipboard = true; 
      };  	
       keyboard.bindings = [ 
        { key = "C"; mods = "Control"; action = "Copy"; } 
        { key = "V"; mods = "Control"; action = "Paste"; }
        { key = "Q"; mods = "Control"; action = "Quit"; } 
        { key = "N"; mods = "Control"; action = "SpawnNewInstance"; }
      ];
    };
  };
}
