{ modifier, terminal, browser, scriptsDir, powerMenuCommand, ... }:

let
  screenshotDir = "$HOME/Downloads";
in 

''
bind = ${modifier},Return,exec,${terminal}
bind = ${modifier},F1,exec,alacritty
bind = ${modifier},F2,exec,browser
bind = ${modifier},F3,exec,google-chrome
bind = ${modifier},M,exit
bind = ${modifier},E,exec,sh ${scriptsDir}/empezar.sh
bind = ${modifier},D,exec,rofi -combi-modi window,drun,ssh ,emoji -font "hack 10" -show combi -show-icons
bind = ${modifier},V,togglefloating
bind = ${modifier}+SHIFT,D,exec,rofi -show power-menu --choices=shutdown/reboot/logout/lockscreen --confirm=logout/lockscreen
bind = ${modifier},Q,killactive
bind = ${modifier}+CTRL,Q,exec,hyprctl dispatch exit
bind = ${modifier},G,togglespecialworkspace,geany

bind = ${modifier},P,exec,sh -c 'grim "${screenshotDir}/$(date +%Y-%m-%d_%H-%M-%S).png"' # Full screenshot to file
bind = ${modifier}+ALT,P,exec,sh -c 'grim -g "$(slurp)" "${screenshotDir}/$(date +%Y-%m-%d_%H-%M-%S).png"' # Region screenshot to file

bind = ${modifier},1,workspace,1
bind = ${modifier},2,workspace,2
bind = ${modifier},3,workspace,3
bind = ${modifier},4,workspace,4
bind = ${modifier},5,workspace,5
bind = ${modifier},6,workspace,6
bind = ${modifier},7,workspace,7
bind = ${modifier},8,workspace,8
bind = ${modifier}+SHIFT,Left,movewindow,l
bind = ${modifier}+SHIFT,Right,movewindow,r
bind = ${modifier}+SHIFT,Up,movewindow,u
bind = ${modifier}+SHIFT,Down,movewindow,d
bind = ${modifier}+CTRL,Left,resizeactive,-20 0
bind = ${modifier}+CTRL,Right,resizeactive,20 0
bind = ${modifier}+CTRL,Up,resizeactive,0 -20
bind = ${modifier}+CTRL,Down,resizeactive,0 20
bind = ${modifier},F,fullscreen
bind = ${modifier}+SHIFT,1,movetoworkspace,1
bind = ${modifier}+SHIFT,2,movetoworkspace,2
bind = ${modifier}+SHIFT,3,movetoworkspace,3
bind = ${modifier}+SHIFT,4,movetoworkspace,4
bind = ${modifier}+SHIFT,5,movetoworkspace,5
bind = ${modifier}+SHIFT,6,movetoworkspace,6
bind = ${modifier}+SHIFT,7,movetoworkspace,7
bind = ${modifier}+SHIFT,8,movetoworkspace,8
bind = ${modifier}+SHIFT,9,movetoworkspace,9
''
