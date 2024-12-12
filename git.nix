{ config, pkgs, ... }:

{
  programs.git = {
  enable = true;
  userName = "Your Name";
  userEmail = "email@example.com";
  aliases = {
    prettylog = "...";
  };
  extraConfig = {
    core = {
      editor = "nvim";
    };
    color = {
      ui = true;
    };
    push = {
      default = "simple";
    };
    pull = {
      ff = "only";
    };
    init = {
      defaultBranch = "main";
    };
  };
  ignores = [
    ".DS_Store"
    "*.pyc"
   ];
  };
}

