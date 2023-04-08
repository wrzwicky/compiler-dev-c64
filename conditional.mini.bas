1000 program conditionaltest is
1010 --
1020 --
1030 -- "This program tests the
1040 -- various conditionals.
1050 --
1060 --
1070 --
1080 float three, four.
1090 --
1100 begin
1110 --
1120 clearscreen. linefeed.
1130 --
1140 assign 3.0 tovar three.
1150 assign 4.0 tovar four.
1160 --
1170 --
1180 writeln "Conditions:".
1190 --
1200 --
1210 if three = four then
1220 --
1230 writeln "Error on =!".
1240 --
1250 else
1260 --
1270 writeln "No error on =".
1280 --
1290 if three > four then
1300 --
1310 writeln "Error on >!".
1320 --
1330 else
1340 --
1350 writeln "No error on >".
1360 --
1370 if three >= four then
1380 --
1390 writeln "Error on >=!".
1400 --
1410 else
1420 --
1430 writeln "No error on >=".
1440 --
1450 if three /= four then
1460 --
1470 writeln "No error on /=".
1480 --
1490 if three < four then
1500 --
1510 writeln "No error on <".
1520 --
1530 if three <= four then
1540 --
1550 writeln "No error on <=".
1560 --
1570 else
1580 --
1590 writeln "Error on <=!".
1600 --
1610 endif.
1620 --
1630 else
1640 --
1650 writeln "Error on <!".
1660 --
1670 endif.
1680 --
1682 else
1684 --
1690 writeln "Error on /=!".
1700 --
1710 endif.
1720 endif.
1730 endif.
1740 endif.
1750 --
1760 pend conditionaltest.
