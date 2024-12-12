{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "espanso-replacer-env";
  buildInputs = with pkgs; [
    pkgs.neofetch
    pkgs.xclip
    (python3.withPackages (ps: with ps; [
      autokey  
      pyperclip
    ]))
    curl
  ];

  shellHook = ''
    echo "Welcome to the Espanso Replacer environment!"
    python espanso_replacer.py
  '';
}

