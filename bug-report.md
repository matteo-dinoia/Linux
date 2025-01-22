# BUG
1. preview of line in okular is messed up
2. intellij does show popup in wrong place (when half maximized)
3. 24h format for sddm not respected
4. sddm virtualkeyboard do nothing if not installed
5. wrong cursor
6. when login notification of virtualdesktop change
7. notification seem strange

# Build command
kdesrc-build workspace kate yakuake ark dolphin konsole spectacle

kdesrc-build workspace kate yakuake ark dolphin konsole spectacle --ignore-modules gpgme poppler --resume-from knotifyconfig/plasma-workspace
