1000 program arithmetic is
1010 --
1020 --
1030 -- This program demonstrates
1040 -- the floating-point arithmetic.
1050 --
1060 --
1070 -- float monica, thomas, cecilia.
1080 -- float tom, dick, harry.
1090 --
1100 --
1110 begin
1120 --
1130 --
1140 clearscreen. linefeed.
1150 writeln "Demonstration of floating-point arithmetic".
1160 linefeed.
1170 --
1180 assign 2 tovar monica.
1190 assign 5 tovar thomas.
1200 assign thomas tovar cecilia.
1210 --
1220 --
1230 write "monica = ". writeln monica.
1240 write "thomas = ". writeln thomas.
1250 write "cecilia = ". writeln cecilia.
1260 --
1270 --
1280 add monica and thomas tovar tom.
1290 linefeed.
1300 write "2 + 5 =". writeln tom.
1310 --
1320 subtract cecilia from tom tovar dick.
1330 write "7 - 2 =". writeln dick.
1340 --
1350 multiply thomas with monica tovar harry.
1360 write "5 x 2 =". writeln harry.
1370 --
1380 divide cecilia by monica tovar dick.
1390 write "5 / 2 =". writeln dick.
1400 --
1410 power monica with thomas tovar tom.
1420 write "2 ^ 5 =". writeln tom.
1430 --
1440 --
1450 pend arithmetic.
