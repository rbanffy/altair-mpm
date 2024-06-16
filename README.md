# altair-mpm

Docker image for running an Altair CP/M 2.2 + MP/M 2.1 computer.

## Basic operation

To start the service locally, run:

```shell
docker run -p 8823:8823 rbanffy/altair-mpm
```

When the service comes up, it listens to port 8823. The emulated machine boots under CP/M 2.2. In order to start MP/M, the first user to connect (running `telnet localhost 8823`) needs to run the MPM.COM program, which loads and starts the MP/M II environment:

```plain


Connected to the Altair 8800 (Z80) simulator Serial Input Output SIO device, line 0


64K CP/M Version 2.2 (SIMH ALTAIR 8800, BIOS V1.23, 2 HD, 20-Oct-02)

A>mpm

MP/M II V2.1 Loader
Copyright (C) 1981, Digital Research
Nmb of consoles     =  4
Breakpoint RST #    =  6
Memory Segment Table:
SYSTEM  DAT  FE00H  0100H
TMPD    DAT  FD00H  0100H
USERSYS STK  FB00H  0200H
XIOSJMP TBL  FA00H  0100H
RESBDOS SPR  EE00H  0C00H
XDOS    SPR  CC00H  2200H
BNKXIOS SPR  BF00H  0D00H
BNKBDOS SPR  9C00H  2300H
BNKXDOS SPR  9A00H  0200H
TMP     SPR  9600H  0400H
LCKLSTS DAT  9300H  0300H
CONSOLE DAT  8F00H  0400H
-------------------------
MP/M II Sys  8F00H  7100H  Bank 0
Memseg  Usr  0000H  B000H  Bank 1
Memseg  Usr  0000H  B000H  Bank 2
Memseg  Usr  0000H  B000H  Bank 3
Memseg  Usr  0000H  B000H  Bank 4
Memseg  Usr  0000H  B000H  Bank 5
Memseg  Usr  0000H  B000H  Bank 6
Memseg  Usr  0000H  B000H  Bank 7

MP/M XIOS (SIMH ALTAIR 8800, V1.11, 2 HD, Banked, 20-Oct-02)


MP/M II V2.1
Copyright (C) 1982, Digital Research

0A>
```

At this point, you are in the MP/M prompt. It shows the current user number (from 0 to 15) and the currently active drive. Up to four users can connect at the same time, and will automatically be directed to different user areas.

## Contents of the Docker image

| Drive | Contents                      |
| ----- | ----------------------------- |
| A:    | System disk                   |
| B:    | Miscellaneous applications    |
| C:    | Sorcim's SuperCalc 2          |
| D:    | Ashton and Tate's dBase II    |
| E:    | MicroPro's WordStar Release 4 |
| F:    | Microsoft's Multiplan 4       |
| G:    | Miscellaneous games           |
| H:    | Borland's Turbo Pascal 3 IDE  |
| I:    | First hard drive, empty       |
| J:    | Second hard drive, empty      |

All files in the disk images are in user area 0.

## Creating empty disk images

In order to create an empty 8GB (the largest size supported under CP/M) hard disk image, use the `dd` utility:

```shell
dd if=/dev/zero bs=1024 count=8192 | tr '\000' '\345' > empty.dsk
```

To create an empty 8" floppy image, use:

```shell
dd if=/dev/zero bs=137 count=8128 | tr '\000' '\345' > i.dsk
```

## Further Reading

The MP/M user's guide is available from <http://www.gaby.de/cpm/manuals/mpm2ug.pdf>.

Information specific to the Altair Z80 emulator can be found at <http://bitsavers.trailing-edge.com/simh.trailing-edge.com_201206/pdf/altairz80_doc.pdf>.
