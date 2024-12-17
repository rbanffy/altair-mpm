10 REM Play with Tektronix graphics
20 ESC$=CHR$(27)
30 GS$=CHR$(29)
40 US$=CHR$(31)
50 CSI$=ESC$+"["
60 PRINT CSI$+"?38h"
70 FOR I = 1 TO 200
80 X=RND(8)*1024: Y=RND(8)*768: GOSUB 1000: C1$=XY$
90 X=RND(9)*1024: Y=RND(9)*768: GOSUB 1000: C2$=XY$
100 PRINT GS$+C1$+C2$+US$+CHR$(13)
110 NEXT
120 REM Pause for a short time
130 FOR I = 1 TO 10000: NEXT
140 PRINT CSI$+"?38l"
150 END
1000 REM calculate coordinate string for (X,Y)
1010 REM returns them in XY$
1020 XY$=CHR$((Y\32) OR 32) + CHR$((Y MOD 32) OR 96) + CHR$((X\32) OR 32) + CHR$((X MOD 32) OR 64)
1030 RETURN
