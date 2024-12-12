#!/bin/sh
if [ "$XDG_SESSION_TYPE" = "x11" ] && [ "$XDG_CURRENT_DESKTOP" = "i3" ]; then
  systemctl --user start espanso
fi

