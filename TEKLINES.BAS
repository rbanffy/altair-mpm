10 REM Play with Tektronix graphics
20 ESC$=CHR$(27)
30 FF$=CHR$(12)
40 GS$=CHR$(29)
50 US$=CHR$(31)
60 CSI$=ESC$+"["
70 REM Tektronix mode
80 PRINT CSI$+"?38h"
90 FOR I = 1 TO 200
100 X=RND(8)*1024: Y=RND(8)*768: GOSUB 1000: C1$=XY$
110 X=RND(9)*1024: Y=RND(9)*768: GOSUB 1000: C2$=XY$
120 PRINT GS$+C1$+C2$+US$+CHR$(13)
130 NEXT
140 REM Pause for a short time
150 FOR I = 1 TO 10000: NEXT
160 REM Clear Tektronix screen
170 PRINT ESC$+FF$
180 REM Switch back to VT mode
190 PRINT ESC$+CHR$(3)+CSI$+"?38l"
200 END
1000 REM calculate coordinate string for (X,Y)
1010 REM returns them in XY$
1020 XY$=CHR$((Y\32) OR 32) + CHR$((Y MOD 32) OR 96) + CHR$((X\32) OR 32) + CHR$((X MOD 32) OR 64)
1030 RETURN
