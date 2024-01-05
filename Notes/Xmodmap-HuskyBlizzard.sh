# Código retirado de AdiulesonArlen em: https://github.com/AdiulesonArlen/HuskyBlizzard-RemapingKeys
# Original
#sleep 30 &&
#xmodmap -e "keycode 62 = Mode_switch" && 
#xmodmap -e "keycode 34 = dead_acute dead_grave Up" && 
#xmodmap -e "keycode 61 = semicolon colon Down" && 
#xmodmap -e "keycode 47 = ccedilla Ccedilla Left" && 
#xmodmap -e "keycode 48 = dead_tilde dead_circumflex Right" &&
#xmodmap -e "keycode 9 = Escape apostrophe quotedbl"

# Mod
sleep 45 &&
xmodmap -e "keycode 135 = Mode_switch" && # keycode 135 = menu key
xmodmap -e "keycode 35 = bracketleft braceleft Up" && # [{ = Up
xmodmap -e "keycode 48 = dead_tilde dead_circumflex Left" && # ~^ = Left
xmodmap -e "keycode 51 = bracketright braceright Right" && # ]} = Right
xmodmap -e "keycode 97 = slash question Down" # ? = Down
xmodmap -e "keycode 9 = Escape apostrophe quotedbl" # add ""
