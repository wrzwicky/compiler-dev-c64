1000 program exittest is
1010 --
1020 --
1030 -- "This program tests
1040 -- the exit instruction.
1050 --
1060 --
1070 float sam, george, harold.
1080 --
1090 begin
1100 --
1105 clearscreen. linefeed.
1110 writeln "Test of the exit instruction.".
1120 linefeed.
1130 --
1140 assign 2.0 tovar sam.
1150 assign 2.0 tovar harold.
1160 assign 7.0 tovar george.
1170 --
1180 --
1190 loop loopa over
1200 --
1210 loop loopb over
1220 --
1230 loop loopc over
1240 --
1250 loop loopd over
1260 --
1270 loop loope over
1280 --
1290 loop loopf over
1300 --
1310 loop loopg over
1320 --
1330 loop looph over
1340 --
1350 --
1360 exit looph if sam /= george.
1370 --
1380 writeln "Error in exit looph.".
1390 --
1400 lend looph.
1410 --
1420 writeln "Exit looph OK.".
1430 --
1440 exit loopg if sam < george.
1450 --
1460 writeln "Error in exit loopg.".
1470 --
1480 lend loopg.
1490 --
1500 writeln "Exit loopg OK.".
1510 --
1520 exit loopf if sam <= george.
1530 --
1540 writeln "Error in exit loopf.".
1550 --
1560 lend loopf.
1570 --
1580 writeln "Exit loopf OK.".
1590 --
1600 exit loope if sam <= harold.
1610 --
1620 writeln "Error in exit loope.".
1630 --
1640 lend loope.
1650 --
1660 writeln "Exit loope OK.".
1670 --
1680 exit loopd if george > harold.
1690 --
1700 writeln "Error in exit loopd.".
1710 --
1720 lend loopd.
1730 --
1740 writeln "Exit loopd OK.".
1750 --
1760 exit loopc if george > harold.
1770 --
1780 writeln "Error in exit loopc.".
1790 --
1800 lend loopc.
1810 --
1820 writeln "Exit loopc OK.".
1830 --
1840 exit loopb if sam >= harold.
1850 --
1860 writeln "Error in exit loopb.".
1870 --
1880 lend loopb.
1890 --
1900 writeln "Exit loopb OK.".
1910 --
1920 exit loopa if sam = harold.
1930 --
1940 writeln "Error in exit loopa.".
1950 --
1960 lend loopa.
1970 --
1980 writeln "Exit loopa OK.".
1990 --
2000 writeln "Test program done.".
2010 --
2020 pend exittest.
