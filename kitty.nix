{ config, pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    # themeFile = "Tokyo Night";
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 14.0;  # Set a default font size
    };
    settings = {
      confirm_os_window_close = -0;
      copy_on_select = true;
      clipboard_control = "write-clipboard read-clipboard write-primary read-primary";
      background_opacity = "0.9";
      scrollback_lines = 10000;          # Increase scrollback buffer size
      cursor_shape = "beam";             # Set cursor shape to beam
      cursor_blink = false;              # Disable cursor blinking
      url_launcher = "xdg-open";         # Use xdg-open to handle URLs
      window_title = "{title} - kitty";  # Customize window title
    };
    keybindings = {
    	"ctrl+shift+c" = "copy_to_clipboard";
    	"ctrl+shift+v" = "paste_from_clipboard";
     	"ctrl+shift+t" = "new_tab";
      	"ctrl+shift+w" = "close_tab";
      	"ctrl+shift+left" = "previous_tab";
      	"ctrl+shift+right" = "next_tab";
    };
  };
}

