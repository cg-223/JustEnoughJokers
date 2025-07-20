#!/bin/bash
aseprite="/mnt/c/Program Files (x86)/Steam/steamapps/common/Aseprite/aseprite.exe"
"$aseprite" "--batch" "rawassets/jokers.aseprite" "--sheet" "assets/1x/jokers.png"
"$aseprite" "--batch" "rawassets/jokers.aseprite" "--sheet" "assets/2x/jokers.png" "--scale" "2"