10 REM Play with Tektronix graphics
20 ESC$=CHR$(27)
30 GS$=CHR$(29)
40 US$=CHR$(31)
50 CSI$=ESC$+"["
60 SZ$="89:;"
70 REM Tektronix mode
80 PRINT CSI$+"?38h"
90 REM Print random-sized text in random positions
100 FOR I=1 TO 200
110 X=RND(8)*1024: Y=RND(8)*768:GOSUB 1000
120 PRINT ESC$+MID$(SZ$,INT(RND(2)*4)+1,1)+"Tektronix"
130 NEXT
140 REM Pause for a short time
150 FOR I = 1 TO 10000: NEXT
160 REM Back to VT mode
170 PRINT CSI$+"?38l"
180 END
1000 REM move-to (X, Y)
1010 GOSUB 2000
1020 PRINT GS$+XY$+US$;
1030 RETURN
2000 REM calculate coordinate string for (X,Y)
2010 REM returns them in XY$
2020 XY$=CHR$((Y\32) OR 32) + CHR$((Y MOD 32) OR 96) + CHR$((X\32) OR 32) + CHR$((X MOD 32) OR 64)
2030 RETURN
