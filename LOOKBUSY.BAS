10 REM Makes the computer look busy
20 FOR I = 1 TO 10
30 PRINT USING "#.#####" + CHR$(9); RND(1),
40 NEXT
50 REM A short delay is needed not to overflow the terminal's buffer
60 REM (not needed on serial terminals with X-ON/X-OFF controls)
70 FOR I = 1 TO 1000: NEXT
80 GOTO 20
