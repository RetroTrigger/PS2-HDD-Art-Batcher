HDLBATCH is intended as a batch game installer for the Playstation 2 HDD
using HDL_DUMP as the main mechanism for transferring games. It supports
CUE/BIN files for CD games, and ISO files for DVD games (including dual-
layered DVDs, aka DVD9). CDs may also be in ISO format (e.g. converted
to be compatible with OPL Manager), or even a mix of both CUE/BIN and
ISO formats.

Game titles can either be specified by a gameid.txt file formatted as:

SCPS_510.01 Moto GP 2 
SCPS_510.04 Bravo Music 
SCPS_510.05 Samurai 
SCPS_510.06 Alpine Racer 3 
SCPS_510.08 Wave Rally 
SCPS_510.09 Underwater Unit 
SCPS_510.10 Shikigami no Shiro 

and a copy has been provided with this release. Please note that some
titles, however, have far more characters than will fit on the OPL game
menu, making some discs titles more difficult to distinguish. Examples
such as "Xenosaga Episode III - Also Sprach Zarathustra [Disc 1]" and
"Xenosaga Episode III - Also Sprach Zarathustra [Disc 2]" suggest that
these two discs would appear identical on the OPL menu if only a fixed
number of characters are displayed. For those games, it is recommended
that the titles be adjusted. Perhaps:

	Xenosaga Ep. III (D1) - Also Sprach Zarathustra

would suffice to keep titles distinct even if OPL menu shortens them.
The gameid.txt file does not need to be sorted, but if multiple entries
exist for a game, it will use the first found entry. The gameid.txt
file provided herein is sorted by region code and numerical ID for
organizational convenience, and is based off of the master list at

	https://github.com/Veritas83/PS2-OPL-CFG

NOTE: If your game title needs to include an exclamation mark (!) make
sure that all exclamation marks are preceeded with a caret (^) symbol.
For example:

	SLUS_209.45 Destroy All Humans^!

is the entry for the game "Destroy All Humans!" (this is required to
work around a quirk with batch files and delayed expansion).

The batch file is setup up to always do a test run first! The test
run simply displays the game type (CD vs DVD), game ID, and title. All
users should use a test run to check that their games will install
correctly. There are several things to look out for:

1.	Every game MUST have a valid game ID. If HDLBATCH cannot find a
	valid game ID, then chances are, your game file is corrupt.
	Verify that the SHA-1 or MD5 checksums match those found on
	redump.org

2.	Make sure that you are happy with HDLBATCH's game titles for your
	game.

After you are satisfied with the output of the test run, edit the single
option called TEST to enable the actual installation.

PLEASE TAKE ALL PRECAUTIONS THAT YOU SELECT THE CORRECT DRIVE TARGET!

For network installations, run hdl_svr_093.elf on the PS2, and then
select option 4 (network). Enter in the IP of the PS2 when prompted. Note
that network installations will most certainly depend on your network
connection. For large installations, a network installation is NOT
recommended (250 games totaling ~625GB takes about 1 hour 45 minutes to
install when attaching the PS2 HDD to the motherboard).

Lastly, because HDLBATCH calls HDL_DUMP, which scans your hardware for PS2
HDDs, you must run with administrator rights. Right click on the batch
file, and select "Run as Administrator" and follow the prompts.

(You may also want to disable your computer's power management so that
your computer does not put itself to sleep in the middle of an install!)


Speeds:

PS2 HDD attached to PC motherboard via SATA	100MB/s - 150MB/s
PS2 HDD via USB3 adapter (varies by adapter)	~70MB/s
PS2 HDD via ethernet				~5MB/s


F.A.Q.

1.	Why HDLBATCH when HDL_HDD_Batcher and HDL Dump Helper GUI already
	exist?

	a) HDL_HDD_Batcher requires CDs and DVDs in two separate
	   directories, and CDs must be in ISO format. CUE/BIN is
	   more appropriate for CD rips. Dual-layered (DVD9) games
	   are installed incorrectly 100% of the time.

	b) HDL Dump Helper GUI requires Java. On modern hardware
	   and newer versions of Windows, the EXE file fails to
	   find a runtime environment even if one is installed,
	   although users may open the .jar file manually. Batch
	   installing is also tedious; each file must be added
	   to the job list. Also, HDHG uses HDL_DUMP 0.9.0, which
	   seems to be much slower at writing to drives attached
	   via USB.

	HLDBATCH uses a newer version of HDL_DUMP which is faster
	for USB-attached drives, and handles all CD and DVD games
	(including dual-layered ones) in one directory. You just
	run the batch file, answer a few questions, and walk away
	until all games are installed.

2.	What about WINHIIP?

	WINHIIP fails to install many games properly. It has a
	hardcoded limit of 255 games (which can be bypassed by
	tediously renaming existing game partitions). It does not
	support 2TB drives. And if users should ever run its
	"repair" feature, games whose titles share the same first
	<x> characters will have collision (i.e. later partitions
	will overwrite previous partitions; this is often an issue
	with multi-disc games or games within a series that have
	long series names).

3.	HDLBATCH said one of my games was not a CD/DVD even though OPL
	loads and plays it fine by USB/SMB. I can even view the ISO or
	CUE/BIN file on my PC. Should I be concerned?

	Chances are, your game file is corrupt. This might mean
	absolutely nothing if, say, dummy filler files do not
	match the official files. It is best, though, to re-rip
	your game and verify the checksum against those found on
	sites like redump.org and be safe rather than sorry should
	your game eventually crash.

4.	My games directory is huge! Is there any way to save the
	test run output into a text file?

	Yes. The test run will prompt you whether you wish to use
	gameid.txt and the only valid answers are Y or N (must be
	capital letters). Any other response will cause a beep.
	After all the info is displayed, the screen will pause
	until you press ENTER. With that in mind, you can run
	HDLBATCH in a command prompt with admin rights as follows:

	HDLBATCH > info.txt

	and this will cause all output to be placed into the file
	named info.txt -- but this will also capture the prompt
	at the beginning and the pause at the end! So you will
	have to answer the question "blind" and then hit ENTER
	after you see the info.txt file in your file explorer
	window with a size greater than 0.
