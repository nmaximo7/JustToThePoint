{ config, pkgs, ... }:

let
  username = config.home.username;
  dotDir = "/home/${username}/dotfiles";
  aliases = import ./aliases.nix;
in

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    plugins = [
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.0.2";
          sha256 = "0y8va5kc2ram38hbk2cibkk64ffrabfv1sh4xm7pjspsba9n5p1y";
        };
      }
    ];

    sessionVariables = {
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE = "underline";
    };

    shellAliases = aliases;


    initExtra = ''
      myripgrep() {
      	rg "$@" ~/justtothepoint/content/
        rg "$@" ~/dotfiles/
      	rg "$@" ~/myNewPython/
      }
      cat() {
      	distrobox enter arch -- cat "$@"
      }
      # fastfetch
      # echo "type inicio"
      # distrobox enter arch -- fortune | cowsay
    '';


  };

  programs.starship = {
    enable = true;
    settings = {
      username = {
        style_user = "blue bold";
        style_root = "red bold";
        format = "[$user]($style) ";
        disabled = false;
        show_always = true;
      };
      hostname = {
        ssh_only = false;
        ssh_symbol = "🌐 ";
        format = "on [$hostname](bold red) ";
        trim_at = ".local";
        disabled = false;
      };
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}

