@echo off
cd /d %~dp0
cd HDD_PFS_Batch_Kit_Manager
rmdir /Q APPS && echo erased APPS folder
rmdir /Q CHT && echo erased CHT folder
rmdir /Q ART && echo erased ART folder
rmdir /Q THM && echo erased THM folder
rmdir /Q VMC && echo erased VMC folder
rmdir /Q CFG && echo erased CFG folder
rmdir /Q TMP && echo erased TMP folder
rmdir /Q POPS && echo erased POPS folder
echo Updating Widescreen hacks file
echo downloading from: "https://github.com/PS2-Widescreen/OPL-Widescreen-Cheats/releases/download/Latest/widescreen_hacks.zip"
BAT\wget.exe -q --show-progress https://github.com/PS2-Widescreen/OPL-Widescreen-Cheats/releases/download/Latest/widescreen_hacks.zip -O WIDE.ZIP

timeout 15
