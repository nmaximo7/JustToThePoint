# /home/nmaximo7/.local/bin/myStartup.nix
{ pkgs ? import <nixpkgs> {} }:

pkgs.writeShellScriptBin "myStartup" ''
  #!${pkgs.zsh}/bin/zsh

  PATH_BLOG=~/justtothepoint
  SITE_URL="http://localhost:1313"

  function kill_blogserv() {
    echo "Starting blog"
    cd $PATH_BLOG || return 1
    ${pkgs.procps}/bin/pkill hugo
  }

  function main() {
    kill_blogserv
    if ${pkgs.procps}/bin/pgrep -x "hugo" > /dev/null
    then
      echo "Hugo server is already running"
    else
      echo "Hugo server is not running. Launching..."
    fi

    if ${pkgs.procps}/bin/pgrep -x "kitty" > /dev/null
    then
      echo "Kitty is already running"
    else
      echo "Kitty is not running. Launching..."
      ${pkgs.kitty}/bin/kitty &
      sleep 1
    fi

    ${pkgs.kitty}/bin/kitty --hold sh -c "${pkgs.hugo}/bin/hugo server --noHTTPCache --disableFastRender --gc --cleanDestinationDir"
  }

  main
''

