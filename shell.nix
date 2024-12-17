{ config, pkgs, ... }:

let
  home = config.home;
in
{
  # Environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    LANG = "en_US.UTF-8";
    BROWSER = "firefox";   # Set default browser to Firefox
  };

  # Zsh configuration will be imported from `zsh.nix`
}

