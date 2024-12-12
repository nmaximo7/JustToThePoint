{ }:

''
  # Assign applications to specific workspaces
  windowrulev2 = workspace 1, class:^(Alacritty)$
  windowrulev2 = workspace 2, class:^(firefox)$
  windowrulev2 = workspace 3, class:^(obsidian)$
  windowrulev2 = workspace 4, class:^(code-oss)$
  windowrulev2 = workspace 4, class:^(Google-chrome)$
  windowrulev2 = workspace 5, class:^(pcmanfm)$
  windowrulev2 = workspace special:geany, class:^(Geany)$
  # windowrule = workspace "special:geany", geany

  # Float VLC and pavucontrol
  windowrulev2 = float, class:^(vlc)$
  windowrulev2 = float, class:^(pavucontrol)$

  # Float Rofi windows
  windowrulev2 = float, class:^(Rofi)$
''
