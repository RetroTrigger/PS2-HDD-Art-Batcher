# [PS2 HDD Art Batcher]( https://github.com/israpps/PS2-HDD-Art-Batcher )

# NO LONGER USING WINHIIP 

WinHiip has been obsolete for a long time, it does not support hard drives of 1TB and above.
The maximum number of installable games is 255, and it formats the hard drive incorrectly

As an alternative you can use The Scripts provided here or [HDL Batch installer]( https://www.psx-place.com/resources/hdl-batch-installer.1173/ ) Instead


# HDLBATCH 

All the tutorials on youtube that explain how to add games to your PS2 hard drive are 99% out of date and totally misinformed

This is a quick and easy batch command line method to Install your PS1 and PS2 games with pfsshell and hdl_dump.
(The PS2 supports hard drives up to 2TB.)

The script converts PS2 CDs (.bin/.cue to .iso) Automatically so you don't need to convert them yourself

You can also Install your APPS, ART, CFG, CHT, THM, VMC Automatically

The script renames your PS2 games automatically during transfer with its titlesid
However, PS1 games will not be renamed automatically.

Speeds Installation: PS2 HDD attached to PC motherboard via SATA	100MB/s  - 150MB/s
Speeds Installation: PS2 HDD via USB3 adapter (varies by adapter)	 70MB/s  - 100MB/s
Speeds Installation: PS2 HDD via ethernet				             5MB/s


# How to formatted hard drive cleanly 

The first thing to do is to cleanly formatted your hard drive with wLaunchELF 4.43a 41e4ebe, this versions is aproximately 2years old, but it is the best version for HDD Management.
https://github.com/israpps/FreeMcBoot-Installer/raw/master/MASS/APPS/ULE-41e4ebe/ULE-41e4ebe.ELF

For Popstarter users, we also reccomend you to download wLaunchELF 4.43a_khn, since it can launch PS1 games easily
https://cdn.discordapp.com/attachments/652863740370485258/742327866854998116/wLE_kHn_20200810.7z

We also recommend you tu use the latest stable OPL Build
https://github.com/ps2homebrew/Open-PS2-Loader/releases/latest

Transfer everything to your USB key
Start your PS2 then go to wLaunchELF (If your USB key is recognized correctly), go to the MASS tab (MASS corresponds to the peripherals connected to USB.)
Then start wLaunchELF that you downloaded above

Once in wLaunchELF go to > /MISC/HddManager
(Why restart wLaunchELF ?. Because you downloaded a more recent version on the github which contains the last updated drivers.)

Once in HddManager, do R1 to display the Menu, choose Format and confirm this choice.
This operation may take between 30 secconds up to 3 minutes (Depending on your HDD and Network adaptor).
During the process your PS2 activates an orange led which flashes to indicate to you that it is working with the hard disk.

Once formatting is complete you'll see that some names appeared at the right side of the screen:
```
__mbr
__net
__system
__sysconf
__common
```
__(There the HDD is properly formatted)__


 Press __R1__ to display the Menu, choose Create.
A window opens, Create the partitions with the following name 


`+OPL`
Choose a partition size that will suit your needs. example: 512Mb
(In this score you will find your APPS, ART, CFG, CHT, THM, VMC. So it's up to you to put a size that will suit your needs)
Pro tip: since partition extension is discouraged create +OPL with enough space, so you'll never need to extend it!

(Optional if you don't want to install games PS1 Do not create the __.POPS partition)
`__.POPS`
Choose a partition size that will suit your needs. example: 20096Mb = (20Gb)
(More info about POPStarter) = https://bitbucket.org/ShaolinAssassin/popstarter-documentation-stuff/wiki/Home

IMPORTANT
Warning If you have installed FreeHDBoot "FHDB" You will have to reinstall it After formatting __before turning off the console__
If you don't have a memory card with FreeMcBoot "FMCB".
We recomend you to use FreeMcBoot (from memory card), however, Keeping FreeHdBoot as a backup is an excellent idea (in case something happens on your mc)

You can use El_isra's Custom FreeMcBoot/FreeHd Installers: https://github.com/israpps/FreeMcBoot-Installer/releases

IMPORTANT
Warning If the size of your partition is too small to copy your PS1 games, your ART, CFG, CHT, THM, VMC
Delete the affected partition (DO NOT EXPAND IT)
(Be careful, this will delete everything in the score)

Exit HddManager with the Triangle key, then turn off your PS2
Reconnect your hard drive in PS2 format to your PC


# Operation & Explanation of batch

The batch 1-Transfer-PS2Games-HDLBATCH
Allows you to install PS2 games in .iso/.bin/.cue format which will automatically rename with the gameid of the game found in the gameid.txt
You can change the game titles in gameid.txt (If you are French rename "gameidFR.txt" to "gameid.txt" to have certain game titles in French.
(Place the .iso/.bin/.cue at the root of the HDLBATCH_v1_15_MORE_PACK folder)

Batch 2-Transfer-APPS-ART-CFG-CHT-THM-VMC
Allows you to install Applications, Artwork, Config, Cheat, Theme, VirtualMemoryCard. In the partition + OPL
(Place them in their respective folder. Example:
"APPS" for Applications ELF
"ART" for game art images
"CFG" for saving per-game configuration files
"CHT" for cheats files
"THM" for themes support
"VMC" for Virtual Memory Card images - from 8MB up to 64MB

The batch 3-Transfer-PS1Games-HDDPOPS (Optional)
Allows you to install PS1 games in .VCD format in the __.POPS partition
However, it does not automatically rename it, it is up to you to rename them.
(Place the .VCD in the POPS folder)


# FAQ 

**HDD error
* 0000045d (1117) The resquest could not be performed because of an I/O device error.
* If you have one or more I/O errors, try formatting your hard drive with the "HDD LLF Low Level Format Tool" software.
https://hddguru.com/software/HDD-LLF-Low-Level-Format-Tool/
* Once finished, try reformattes the hard drive in PS2 format with wLaunchELF
* If after that you still have error I/O flashing that your SATA adapter to USB is not dysfunctional. Or check the health of your hard drive with the "DiskInfo" software. 
https://crystalmark.info/en/download/#CrystalDiskInfo

**My hard drive in PS2 format does not appear in the list
* If your PS2 format disc does not appear, your SATA to USB adapter is not working correctly
* Or that your hard drive is not detected for some other reason

**My hard drive in PS2 format is correctly detected but I cannot select it from the list
* If you have several hard drives, the one in PS2 format may appear in hdd4 or hdd5 etc. there are two solutions
* The first is to disconnect all the other hard drives except the one in PS2 format
* The second is to modify a line in the Transfer-PS2Games-HDLBATCH.bat batch
* Line 126 (set hdlhdd = hdd3:) modify the hdd3 to hdd4 or hdd5 etc .. everything will depend on the number of the hard disk in PS2 format.
NOTE: You must always select the number 3 to select the hdd4 or hdd5 hard drive etc ... in the command prompt.

**Installation problem for a game:
* SCES_555.10.Jak and Daxter: The Lost Frontier
* At the installation I had a bug the game could not install it must be installed manually with hdl_dumb.exe
* And Add the id manually in Startup:
* (Maybe this can happen with other games)

**Add PS1 games to the additional POPS score. __.POPS0 __.POPS1 __.POPS2 etc ...
* If your __.POPS partition is full you can create another one with the following name __.POPS0 __.POPS1 etc ... up to __.POPS9 at most
* With NotePAD ++ modify the batch 3-Transfer-PS1Games-HDDPOPS.bat
* Do " CTRL + F " Go to the "Replace" tab search for __.POPS in replace by put: __.POPS0 , or __.POPS1 etc .. press "Replace all"


# CREDIT 

These scripts are not mine (GDX) I just have them modify and combine to add features like
- More ID in gameid.txt (+ some translation for French games)
- The possibility of adding the Cheats (CHT) in the +OPL partition
- The possibility of adding the Applications (APPS) in the +OPL partition
- Automatic admin execution for HDLBATCH.

The original authors of the scripts used

- rs1n = https://www.psx-place.com/threads/hdlbatch-batch-installer-for-ps2-hdds.26885/
- NeMesiS = https://gbatemp.net/threads/ps2-hdd-batchkit-2tb-support.544600/ 
- AKuHAK = https://github.com/ps2homebrew/hdl-dump
- uyjulian https://github.com/ps2homebrew/pfsshell

POPStarter documentation = https://bitbucket.org/ShaolinAssassin/popstarter-documentation-stuff/wiki/Home

Officel PS2 Forum = https://www.psx-place.com

Discord = https://discord.gg/Yr9rJQRz
