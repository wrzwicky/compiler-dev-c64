!- 4.9 PRINTING THE PARSER OUTPUT

1000 rem program for output of
1010 rem mini-syn
1020 rem
1030 rem ----------------- -------

1040 print chr$(147);chr$(14)
1050 print"output to printer (p) or screen (s) ?"
1060 get w$ : if w$= "p" then pr=4 : goto 1085
1070 if w$= "s" then pr=3 : goto 1085
1080 goto 1060
1085 print"with line numbers (y) ? "
1087 get w$ : if w$= "" then 1087
1089 if w$="y" then ss=1
1100 open pr, pr
1110 in=8
1120 open in,in,in,"mini-syn,s,r"
1130 get#in, w$
1140 get#in,w$ : if w$= "" then w=o : goto 1160
1150 w=asc (w$)
1160 if w=253 then print#pr,chr$(13);
1165 if w<>253 then 5000
1166 get#in,w$ : w=asc(w$)

1170 if w=1  then print#pr,"program identifier definition          "; : goto 1130
1180 if w=2  then print#pr,"definitions start                      "; : goto 1130
1190 if w=3  then print#pr,"definitions end                        "; : goto 1130
1200 if w=4  then print#pr,"program identifer check                "; : goto 1130
1210 if w=5  then print#pr,"program end                            "; : goto 1130
1220 if w=6  then print#pr,"subroutine identifier                  "; : goto 1130
1230 if w=7  then print#pr,"subroutine identifer check             "; : goto 1130
1240 if w=8  then print#pr,"output                                 "; : goto 1130
1250 if w=9  then print#pr,"output with linefeed                   "; : goto 1130
1260 if w=10 then print#pr,"linefeed                               "; : goto 1130
1270 if w=11 then print#pr,"clearscreen                            "; : goto 1130
1280 if w=12 then print#pr,"cursor column                          "; : goto 1130
1290 if w=13 then print#pr,"cursor line                            "; : goto 1130
1300 if w=14 then print#pr,"output ascii                           "; : goto 1130
1310 if w=15 then print#pr,"device                                 "; : goto 1130
1320 if w=16 then print#pr,"border                                 "; : goto 1130
1330 if w=17 then print#pr,"background                             "; : goto 1130
1340 if w=18 then print#pr,"type                                   "; : goto 1130
1350 if w=19 then print#pr,"input                                  "; : goto 1130
1360 if w=20 then print#pr,"assign                                 "; : goto 1130
1400 if w=21 then print#pr,"add                                    "; : goto 1130
1410 if w=22 then print#pr,"subtract                               "; : goto 1130
1420 if w=23 then print#pr,"multiply                               "; : goto 1130
1430 if w=24 then print#pr,"divide                                 "; : goto 1130
1440 if w=25 then print#pr,"power                                  "; : goto 1130
1450 if w=26 then print#pr,"generate                               "; : goto 1130
1460 if w=27 then print#pr,"period                                 "; : goto 1130
1500 if w=28 then print#pr,"decision                               "; : goto 1130
1510 if w=29 then print#pr,"else                                   "; : goto 1130
1520 if w=30 then print#pr,"decision end                           "; : goto 1130
1530 if w=31 then print#pr,"infinite loop                          "; : goto 1130
1540 if w=32 then print#pr,"infinite loop end                      "; : goto 1130
1550 if w=33 then print#pr,"exit                                   "; : goto 1130
1560 if w=34 then print#pr,"index loop                             "; : goto 1130
1600 if w=35 then print#pr,"loop start                             "; : goto 1130
1610 if w=36 then print#pr,"index loop end                         "; : goto 1130
1620 if w=37 then print#pr,"jump label                             "; : goto 1130
1630 if w=38 then print#pr,"jump                                   "; : goto 1130
1640 if w=39 then print#pr,"call                                   "; : goto 1130
1650 if w=40 then print#pr,"floating-point number                  "; : goto 1130
1660 if w=41 then print#pr,"variable                               "; : goto 1130
1700 if w=42 then print#pr,"generate-1                             "; : goto 1130  
1710 if w=43 then print#pr,"operator =                             "; : goto 1130  
1720 if w=44 then print#pr,"operator /=                            "; : goto 1130  
1730 if w=45 then print#pr,"operator <                             "; : goto 1130  
1740 if w=46 then print#pr,"operator <=                            "; : goto 1130  
1750 if w=47 then print#pr,"operator >                             "; : goto 1130  
1760 if w=48 then print#pr,"operator >=                            "; : goto 1130  
1800 if w=49 then print#pr,"decimal places                         "; : goto 1130  
1810 if w=50 then print#pr,"no exponent                            "; : goto 1130  
1820 if w=51 then print#pr,"exponent                               "; : goto 1130  
1830 if w=52 then print#pr,"plus                                   "; : goto 1130
1840 if w=53 then print#pr,"minus                                  "; : goto 1130
1850 print#pr,"error ! ! ! ! ! ";
1860 stop

5000 rem routine w>54
5010 if w=255 then print#pr,chr$(13)"-end of file-"; : goto 13000
5020 if w=254 and ss=1 then print#pr,chr$(13)"linenumber   :"; : goto 14000
5025 if w=254 then goto 14000
5100 if w=55 then print#pr,chr$(13)"identifier : "; : goto 10000
5110 if w=57 then print#pr,chr$(13)"string     : "; : goto 11000
5120 if w=59 then print#pr,chr$(13)"integer    : "; : goto 12000

10000 rem read identifer
10010 get#in,w$ : if w$=chr$(255) then 1140
10020 print#pr,w$;
10030 goto 10010

11000 rem read string
11010 get#in,w$ : if w$=chr$(255) then 1140
11020 print#pr, w$;
11030 goto 10010

12000 rem read integer
12010 get#in,w$ : if w$=chr$(255) then 1140
12020 print#pr,w$;
12030 goto 10010

13000 rem program end
13010 close pr
13020 close in
13030 end

14000 rem line number
14010 get#in,w$ : if w$="" then z=o : goto 14020
14015 z=asc (w$)
14020 get#in,w$ : if w$="" then goto 14025
14022 z=z+asc (w$) *256
14025 if ss=1 then print#pr,z;
14030 goto 1130
