10 REM Play with Tektronix graphics
20 ESC$=CHR$(27)
30 GS$=CHR$(29)
40 US$=CHR$(31)
50 CSI$=ESC$+"["
60 PRINT CSI$+"?38h"
70 REM Print text in four sizes
80 PRINT ESC$+"8Tektronix"
90 PRINT ESC$+"9Tektronix" 
100 PRINT ESC$+":Tektronix"
110 PRINT ESC$+";Tektronix"
120 REM Pause for a short time
130 FOR I = 1 TO 10000: NEXT
140 PRINT CSI$+"?38l"
