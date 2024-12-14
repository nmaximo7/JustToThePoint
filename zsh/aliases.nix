{
      rebuild = "sudo nixos-rebuild switch";
      hyprreload = "hyprctl reload";
      nix-clean = "nix-collect-garbage -d";
      ll = "exa -a --icons";
      tree = "exa --tree --icons";
      gs = "git status";
      reload = "source ~/.zshrc";
      ferdium = "distrobox-enter arch -- ferdium";
      cmatrix = "distrobox enter arch -- cmatrix";
      greetings = "distrobox enter arch -- fortune | cowsay";
      greetings-big = "cd ~/myNewPython && nix-shell && python greeting.py";
      bracket = "echo \(\)\[\]~ @\|{} && copyq copy '()[]~@\|' && copyq clipboard";
      df = "df -h";  # df reports file system disk usage with human-readable sizes.
      free= "free -m"; # free displays the total amount of free and used memory in the system in MB
      webserver = "/nix/store/i1ryyybhfvphywjygdw1jvnnbv5mfkdh-myStartup/bin/myStartup";
      kill-hugo = "pkill hugo";
      imageConverter = "/nix/store/3ppzkbmiq3k706jbsx766990ga1fjjxy-image-converter/bin/image-converter";
      gedit = "org.gnome.gedit";
      gimp = "org.gimp.GIMP";
      filezilla = "org.filezillaproject.Filezilla";
      # google-chrome = "distrobox enter arch -- google-chrome-stable --force-device-scale-factor=1.5 --custom-chrome-frame";
      google-chrome = "com.google.Chrome";
      myespanso = "cd /home/nmaximo7/dotfiles/Espanso && nix-shell";
      inicio = "cd /home/nmaximo7/dotfiles/scripts && sh ./inicio.sh";
      help = "cd /home/nmaximo7/dotfiles/scripts && sh ./help.sh";
      maintaince = "cd /home/nmaximo7/dotfiles/scripts && sh ./maintaince.sh";
 
}
