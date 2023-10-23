// https://github.com/AdiulesonArlen/HuskyBlizzard-RemapingKeys
xmodmap -e "keycode 62 = Mode_switch" && 
xmodmap -e "keycode 34 = dead_acute dead_grave Up" && 
xmodmap -e "keycode 61 = semicolon colon Down" && 
xmodmap -e "keycode 47 = ccedilla Ccedilla Left" && 
xmodmap -e "keycode 48 = dead_tilde dead_circumflex Right" &&
xmodmap -e "keycode 9 = Escape apostrophe quotedbl"
