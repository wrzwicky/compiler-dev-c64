1000 program even is
1010 --
1020 --
1030 --"This program reads a number
1040 -- from the keyboard and determines
1050 -- whether this number is
1060 -- even or odd.
1070 --
1080 --
1090 float number, temp, two, zero, tempv.
1100 --
1110 begin
1120 --
1130 clearscreen. linefeed. assign 2 tovar two.
1140 --
1150 write "Please enter a positive integer.".
1160 get number. linefeed.
1170 --
1180 --
1190 assign number tovar temp.
1200 divide temp by two tovar temp.
1210 generate integer from temp.
1220 divide number by two tovar tempv.
1230 subtract temp from tempv tovar temp.
1240 --
1250 assign 0.0 tovar zero.
1260 --
1270 if temp = zero then
1280 --
1290 write number. writeln "This is an even number.".
1300 --
1310 else
1320 --
1330 write number. writeln "This is an odd number.".
1340 --
1350 endif.
1360 --
1370 pend even.
