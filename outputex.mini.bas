1000 program outputex is
1010 --
1020 --
1030 -- This program clears the screen,
1040 -- sets the cursor to line 5, column 5,
1050 -- outputs the sentence "Output on the screen"
1060 -- in reverse type, creates 2 blank lines,
1070 -- and then outputs this sentence
1080 -- once again in normal type.
1090 --
1100 --
1110 begin
1120 --
1130 clearscreen.
1140 --
1150 curslin 5. curscol 5.
1160 --
1170 writeas 18.
1180 --
1190 write "Output on the screen".
1200 --
1210 writeas 146.
1220 --
1230 linefeed. linefeed. linefeed.
1240 --
1250 writeln "Output to the screen".
1260 --
1270 --
1280 pend outputex.
