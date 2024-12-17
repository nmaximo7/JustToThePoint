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
      prompt1 = "echo 'Could you please clarify, proofread, explain and expand the explanation as more as possible (context Calculus I-V) to make it more comprehensive and accessible. Please be precise, verbose, avoid hallucinations and do not worry about time, but precision. Thank you very much for your aid and support, I do appreciate it. If I make a mistake (grammar, spelling or in the logic), please tell me the mistake, mark it in red and the solution'";
      prompt2 = "echo 'Create a drawing in a 16:9 aspect ratio with a girl studying maths from a book in her bedroom in anime style'";
      quote = "awk -v RS='%' 'NR > 1 {a[NR-1] = $0} END {srand(); print a[int(rand()*length(a))+1]}' /home/nmaximo7/dotfiles/docs/assets/fortunes | sed '/^$/d'
";
      backup = "sh /home/nmaximo7/dotfiles/scripts/mybackup.sh";
      maintaining = "sh /home/nmaximo7/dotfiles/scripts/maintaince.sh";
      deploy = "sh /home/nmaximo7/dotfiles/scripts/deploy.sh";
      check = "sh /home/nmaximo7/dotfiles/scripts/check.sh";
      nixedit="sudo nvim /etc/nixos/configuration.nix";
      homeedit = "gedit /home/nmaximo7/dotfiles/home-manager.nix";
      hyperedit = "gedit /home/nmaximo7/dotfiles/hyperland/hyperland.nix";
}
