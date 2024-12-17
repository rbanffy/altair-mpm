10 REM Makes the computer look busy
20 FOR I = 1 TO 9
30 PRINT USING "#.#####" + CHR$(9); RND(1),
40 NEXT
50 PRINT
60 REM A short delay is needed not to overflow the terminal's buffer
70 REM (not needed on serial terminals with X-ON/X-OFF controls)
80 FOR I = 1 TO 1000: NEXT
90 GOTO 20
