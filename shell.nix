{ config, pkgs, ... }:

let
  home = config.home;
in
{
  # Environment variables
  home.sessionVariables = {
    EDITOR = "vim";
    VISUAL = "vim";
    LANG = "en_US.UTF-8";
    BROWSER = "firefox";   # Set default browser to Firefox
  };

  # Zsh configuration will be imported from `zsh.nix`
}

