!- renamed pyquarter due to CBM prg Studio translating 'pi'

1000 program functions is
1010 --
1020 --
1030 -- This program demonstrates
1040 -- the use of functions in
1050 -- the language MINI.
1060 --
1070 --
1080 float a, b, c, d, e, f, g.
1090 float pyquarter.
1110 --
1120 begin
1130 assign 4 tovar a.
1140 assign 4 tovar b.
1150 assign 3.1415 tovar c.
1160 divide c by b tovar pyquarter.
1170 --
1180 clearscreen.
1190 writeln "Demonstration of functions".
1200 --
1210 linefeed.
1220 generate integer from c tovar d.
1230 --
1240 -- The integer from c was
1250 -- calculated and stored in d.
1260 -- c was not changed.
1270 --
1280 write " c = ". writeln c.
1290 write " d = ". writeln d.
1300 --
1310 generate absolute from a.
1320 --
1330 -- The contents of a
1340 -- are changed by this form.
1350 --
1360 write " absolute value of 4 = ". writeln a.
1370 --
1380 --
1390 generate arctangent from pyquarter tovar e.
1400 write " arctangent of pi/4 = ". writeln e.
1410 --
1420 generate cosine from pyquarter tovar e.
1430 write " cosine from pyquarter = ". writeln e.
1440 --
1450 generate exponent from b tovar e.
1460 write "exponent of 4 =". writeln e.
1470 --
1480 generate integer from pyquarter tovar e.
1490 write " integer of pi/4 =". writeln e.
1500 --
1510 generate logarithm from b tovar e.
1520 write" logarithm of 4 =". writeln e.
1530 --
1540 generate memoryvalue from b tovar f.
1550 write " contents of address 4 =". writeln f.
1560 --
1570 generate random from a tovar g.
1580 write " random of a=". writeln g.
1590 --
1600 generate sign from b tovar g.
1610 write " sign of 4 =". writeln g.
1620 --
1630 generate sine from pyquarter tovar f.
1640 write " sine of pi/4 =". writeln f.
1650 --
1660 generate squareroot from b tovar g.
1670 write " square root of 4 =". writeln g.
1680 --
1690 generate tangent from pyquarter tovar f.
1700 write " tangent of pi/4 =". writeln f.
1710 --
1720 writeln "did everything work?".
1730 --
1740 --
1750 pend functions.
