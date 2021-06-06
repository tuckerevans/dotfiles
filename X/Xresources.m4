include(m4_defaults.m4)
Xft.dpi: EVANS_DISPLAY_DPI
XTerm*faceName:  EVANS_TERM_FONT
UXTerm*faceName: EVANS_TERM_FONT

XTerm*faceSize:  EVANS_TERM_FONT_SIZE
UXTerm*faceSize: EVANS_TERM_FONT_SIZE

*termName: xterm-256color

XTerm*allowBoldFont: false
UXTerm*allowBoldFont: false
XTerm*boldMode: false
UXTerm*boldMode: false

XTerm*colorBDMode: true
UXTerm*colorBDMode: true

*VT100*translations: #override Shift <Btn1Up>: exec-formatted("firefox '%t'", PRIMARY)
XTerm*on3Clicks: regex ([[:alpha:]]+://)?([[:alnum:]!#+,./=?@_~-]|(%[[:xdigit:]][[:xdigit:]]))+

!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!! COLORS (serious business) !!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
*.foreground: FOREGROUND
*.background: BACKGROUND

! black
*.color0: BLACK
*.color8: BLACK_BOLD

! red
*.color1: RED
*.color9: RED_BOLD

! green
*.color2: GREEN
*.color10: GREEN_BOLD

! yellow / orange
*.color3: YELLOW
*.color11: YELLOW_BOLD

! blue
*.color4: BLUE
*.color12: BLUE_BOLD

! magenta
*.color5: MAGENTA
*.color13: MAGENTA_BOLD

! cyan
*.color6: CYAN
*.color14: CYAN_BOLD

! white
*.color7: WHITE
*.color15: WHITE_BOLD
