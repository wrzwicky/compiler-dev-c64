!- 5.1 THE SEMANTIC ANALYSIS PROGRAM

500 dim b$(500) : dim t%(500)
510 dim i(40) : iz=o : lz=o

1000 print "compile with trace (y/n) ?"
1010 get w$ : if w$="" then 1010
1020 if w$="y" then sp=1
1030 print "output to printer (p) or to screen (s) ?"
1040 get w$ : if w$="" then 1040
1050 if w$="p" then pr=4 : goto 1080
1060 if w$="s" then pr=3 : goto 1080
1070 goto 1040

1080 print "please insert data disk"
1090 print "and press < return > ."
1100 get w$ : if w$= "" then 1100
1110 open pr, pr
1120 open 15,8,15,"i"
1130 print#15,"s:mini-src"
1140 input#15,en,em$,et,es
1150 if en<>1 then goto 60020

1160 ou=9 : open ou,8,ou,"0:mini-src,p,w"
1170 gosub 60000
1180 in=8 : open in,8,in,"0:mini-syn,s,r"
1190 gosub 60000

1200 pc=2049 : rem basic start address in of your computer
1210 p1=int(pc/256)
1220 p2=pc-p1*256
1230 print#ou,chr$(p2)chr$(p1);

2000 rem output of the subroutines
2010 ou$="lda #14" : gosub 59000
2020 ou$="jsr $ffd2" : gosub 59000
2030 ou$="lda #144" : gosub 59000
2040 ou$="jsr $ffd2" : gosub 59000
2050 ou$="lda #6" : gosub 59000
2060 ou$="sta 53281" : gosub 59000
2070 ou$="sta 53280" : gosub 59000
2080 ou$="jmp declaration" : gosub 59000
2090 ou$="zvor .m" : gosub 59000
2100 ou$="lda #13" : gosub 59000
2110 ou$="jsr $ffd2" : gosub 59000
2120 ou$="rts" : gosub 59000
2130 ou$="aus .m" : gosub 59000
2140 ou$="jsr $bddd" : gosub 59000
2150 ou$="ldx #0" : gosub 59000
2160 ou$="ausp .m" : gosub 59000
2170 ou$="lda $0100,x" : gosub 59000
2180 ou$="beq ause" : gosub 59000
2190 ou$="jsr $ffd2" : gosub 59000
2200 ou$="inx" : gosub 59000
2210 ou$="bne ausp" : gosub 59000
2220 ou$="ause .m" : gosub 59000
2230 ou$="rts" : gosub 59000
2240 ou$="ein .m" : gosub 59000
2250 ou$="lda #$3f" : gosub 59000
2260 ou$="jsr $ffd2" : gosub 59000
2270 ou$="ldx #0" : gosub 59000
2280 ou$="ein1 .m" : gosub 59000
2290 ou$="jsr $ffcf" : gosub 59000
2300 ou$="sta $0220,x" : gosub 59000
2310 ou$="inx" : gosub 59000
2320 ou$="cmp #$d" : gosub 59000
2330 ou$="bne einl" : gosub 59000
2340 ou$="jsr $ffd2" : gosub 59000
2350 ou$="lda #$02" : gosub 59000
2360 ou$="sta $23" : gosub 59000
2370 ou$="lda #$20" : gosub 59000
2380 ou$="sta $22" : gosub 59000
2390 ou$="dex" : gosub 59000
2400 ou$="txa" : gosub 59000
2410 ou$="jsr $b7b5" : gosub 59000
2420 ou$="rts" : gosub 59000
2430 ou$=".c" : gosub 59000
2440 ou$=".t "+chr$(34)+ "line : "+chr$(34) : gosub 59000
2450 ou$="spur .m" : gosub 59000
2460 ou$="jsr zvor" : gosub 59000
2470 ou$="ldy # ch" : gosub 59000
2480 ou$="lda # cl" : gosub 59000
2490 ou$="jsr $ab1e" : gosub 59000
2500 ou$="rts" : gosub 59000
2990 ou$="declaration .m" : gosub 59000

5000 rem semantic loop
5010 get#in,i$
5020 get#in,i$ : if i$="" then i=o : goto 5040
5030 i=asc(i$)
5035 if i=55 then 9000
5040 if i<>253 then 6000
5050 get#in,i$ : i=asc(i$)
5060 if i=1 then 10000
5070 if i=2 then 10500
5080 if i=3 then 11000
5090 if i=4 then 11500
5100 if i=5 then 12000
5110 if i=6 then 12500
5120 if i=7 then 13000
5130 if i=8 then 13500
5140 if i=9 then 14000
5150 if i=10 then 14500
5160 if i=11 then 15000
5170 if i=12 then 15500
5180 if i=13 then 16000
5190 if i=14 then 16500
5200 if i=l5 then 17000
5210 if i=16 then 17500
5220 if i=17 then 18000
5230 if i=18 then 18500
5240 if i=19 then 19000
5250 if i=20 then 19500
5260 if i=21 then 20000
5270 if i=22 then 20500
5280 if i=23 then 21000
5290 if i=24 then 21500
5300 if i=25 then 22000
5310 if i=26 then 22500
5320 if i=27 then 23000
5330 if i=28 then 23500
5340 if i=29 then 24000
5350 if i=30 then 24500
5360 if i=31 then 25000
5370 if i=32 then 25500
5380 if i=33 then 26000
5390 if i=34 then 26500
5400 if i=35 then 27000
5410 if i=36 then 27500
5420 if i=37 then 28000
5430 if i=38 then 28500
5440 if i=39 then 29000

5500 print#pr,"semantic program error: token=";i
5510 close ou : close in : close 15
5520 end

6000 if i=254 then 30000
6010 if i=255 then 31000
6020 print#pr,"semantic program error: token=";i
6030 close ou : close in : close 15
6040 end

9000 rem variable definition
9010 if df=0 then gosub 56040
9020 if df=0 then me$="variables are declared in definition section!" : goto 58700
9030 gosub 56040
9040 be$=i1$ : ty%=3 : gosub 57000
9050 if sc=1 then me$="identifer already defined !" : goto 58700
9060 gosub 57500
9070 ou$=be$+" .bl 5" : gosub 59000
9080 goto 5020

10000 rem program identifer definition
10005 gosub 56000
10010 be$=i1$ : ty%=1 : gosub 57000
10020 if sc=1 then me$="program identifier already defined!" : goto 58700
10030 gosub 57500
10040 goto 5020

10500 rem definition section start
10505 ou$="jmp definitionsende" : gosub 59000
10507 ou$="immersys .bl 5" : gosub 59000
10510 df=1 : goto 5000

11000 rem definition section end
11005 ou$="definitionsende .m" : gosub 59000
11010 df=0 : goto 5000

11500 rem program identifier check
11505 gosub 56000
11510 be$=i1$ : ty%=1 : gosub 57000
11520 if sc=0 then me$="program identifier not defined!" : goto 58700
11540 goto 5020

12000 rem program end
12010 ou$="lda #$76" : gosub 59000
12020 ou$="ldy #$a3" : gosub 59000
12030 ou$="jsr $ab1e" : gosub 59000
12040 ou$="jmp $a480" : gosub 59000
12050 ou$=".end" : gosub 59000
12060 goto 5000

12500 rem subroutine identifier definition
12505 gosub 56000
12510 be$=i1$ : ty%=2 : gosub 57000
12520 if sc=1 then me$="program identifier already defined!" : goto 58700
12530 gosub 57500
12535 ou$="u-"+be$+" .m" : gosub 59000
12540 goto 5020

13000 rem subroutine identifier check
13005 gosub 56000
13010 be$=i1$ : ty%=2 : gosub 57000
13020 if sc=0 then me$="program identifier not defined!" : goto 58700
13030 ou$="rts" : gosub 59000
13040 goto 5020

13500 rem output
13510 gosub 13600
13520 goto 5020
13600 gosub 55000
13610 if i<>255 then me$="new symbol expected !" : gosub 58500 : return
13630 gosub 55000
13640 if i=55 then i1$="" : gosub 56040 : goto 13800
13650 i1$="" : gosub 56340
13652 d9=d9+1
13654 d9$=mid$(str$(d9),2,len(str$(d9))-1)
13656 ou$="jmp de"+d9$ : gosub 59000
13660 ou$=".c" : gosub 59000
13670 ou$=".t "+chr$(34)+i1$+chr$(34) : gosub 59000
13675 ou$="de"+d9$+" .m" : gosub 59000
13680 ou$="ldy # ch" : gosub 59000
13690 ou$="lda # cl" : gosub 59000
13700 ou$="jsr $ab1e" : gosub 59000
13710 return
13800 be$=i1$ : ty%=3 : gosub 57000
13810 if sc=o then me$="identifier not defined !" : goto 58700
13820 gosub 54000
13830 ou$="jsr aus" : gosub 59000
13840 return

14000 rem output with linefeed
14010 gosub 13600
14020 ou$="jsr zvor" : gosub 59000
14030 goto 5020

14500 rem linefeed
14510 ou$="jsr zvor" : gosub 59000
14520 goto 5000

15000 rem sclearscreen
15010 ou$="jsr $e544" : gosub 59000
15020 goto 5000

15500 rem cursor column
15510 gosub 56500
15520 if val(i1$)>40 then me$="column number greater than 40" : goto 58700
15530 if val(i1$)<1 then me$="column number less than 1 " : goto 58700
15540 ou$="sec" : gosub 59000
15550 ou$="jsr $fff0" : gosub 59000
15560 ou$="clc" : gosub 59000
15570 ou$="ldy #"+str$(val(i1$)-1) : gosub 59000
15580 ou$="jsr $fff0" : gosub 59000
15590 goto 5020

16000 rem cursor line
16010 gosub 56500
16020 if val(i1$)>24 then me$="line number greater than 24!" : goto 58700
16030 if val(i1$)<1 then me$="line number less than 1 !" : goto 58700
16040 ou$="sec" : gosub 59000
16050 ou$="jsr $fff0" : gosub 59000
16060 ou$="clc" : gosub 59000
16070 ou$="ldx #"+str$(val(i1$)-1) : gosub 59000
16080 ou$="jsr $fff0" : gosub 59000
16090 goto 5020

16500 rem output ascii
16510 gosub 56500
16520 ou$="lda #"+i1$ : gosub 59000
16530 ou$="jsr $ffd2" : gosub 59000
16540 goto 5020

17000 rem device
17010 gosub 56000
17020 if i1$="screen" then 17200
17030 if i1$="printer" then 17300
17040 me$= "unknown device  !  " : goto 58700

17200 rem device screen
17210 ou$= "jsr zvor" : gosub 59000
17220 ou$= "jsr $ffcc" : gosub 59000
17230 ou$= "lda #4" : gosub 59000
17240 ou$= "jsr $ffc3 " : gosub 59000
17250 goto 5020

17300 rem device printer
17310 ou$= "lda #4" : gosub 59000
17320 ou$= "sta 184" : gosub 59000
17330 ou$= "sta 186" : gosub 59000
17340 ou$= "lda #7" : gosub 59000
17350 ou$= "sta 185" : gosub 59000
17360 ou$= "lda #0" : gosub 59000
17370 ou$= "sta 183" : gosub 59000
17380 ou$= "jsr $ffc0" : gosub 59000
17390 ou$= "ldx #4" : gosub 59000
17400 ou$= "jsr $ffc9" : gosub 59000
17410 goto 5020

17500 rem border
17510 gosub 56000
17520 ff=-1
17530 if i1$="black" then ff=0
17540 if i1$="white" then ff=1
17550 if i1$="red" then ff=2
17560 if i1$="cyan" then ff=3
17570 if i1$="purple" then ff=4
17580 if i1$="green" then ff=5
17590 if i1$="blue" then ff=6
17600 if i1$="yellow" then ff=7
17610 if i1$="orange" then ff=8
17620 if i1$="brown" then ff=9
17630 if i1$="ltred" then ff=10
17640 if i1$="greya" then ff=11
17650 if i1$="greyb" then ff=12
17660 if i1$="greyc" then ff=15
17670 if i1$="ltgreen" then ff=13
17680 if i1$="ltblue" then ff=14
17690 if ff=-1 then me$="unknown color "+i1$ : goto 58700
17700 ou$="lda #" +str$(ff) : gosub 59000
17710 ou$="sta 53280" : gosub 59000
17720 goto 5020

18000 rem background
18010 gosub 56000
18020 ff=-1
18030 if i1$="black" then ff=0
18040 if i1$="white" then ff=1
18050 if i1$="red" then ff=2
18060 if i1$="cyan" then ff=3
18070 if i1$="purple" then ff=4
18080 if i1$="green" then ff=5
18090 if i1$="blue" then ff=6
18100 if i1$="yellow" then ff=7
18110 if i1$="orange" then ff=8
18120 if i1$="brown" then ff=9
18130 if i1$="ltred" then ff=10
18140 if i1$="greya" then ff=11
18150 if i1$="greyb" then ff=12
18160 if i1$="greyc" then ff=15
18170 if i1$="ltgreen" then ff=13
18180 if i1$="ltblue" then ff=14
18190 if ff=-1 then me$="unknown color "+i1$ : goto 58700
18200 ou$="lda #"+str$(ff) : gosub 59000
18210 ou$="sta 53281" : gosub 59000
18220 goto 5020

18500 rem type
18510 gosub 56000
18520 ff=-1
18530 if i1$="black" then ff=144
18540 if i1$="white" then ff=5
18550 if i1$="red" then ff=28
18560 if i1$="purple" then ff=156
18580 if i1$="green" then ff=30
18590 if i1$="blue" then ff=31
18600 if i1$="yellow" then ff=158
18610 if i1$="cyan" then ff=159
18690 if ff=-1 then me$="unknown color "+i1$ : goto 58700
18700 ou$="lda #"+str$(ff) : gosub 59000
18710 ou$="jsr $ffd2" : gosub 59000
18720 goto 5020

19000 rem input
19010 gosub 56000
19020 be$=i1$ : ty%=3 : gosub 57000
19030 if sc=0 then me$="identifier not defined !" : goto 58700
19040 ou$="jsr ein" : gosub 59000
19050 gosub 53000
19060 goto 5020

19400 rem assign variable
19410 gosub 56000
19420 be$=i1$ : ty%=3 : gosub 57000
19430 if sc=0 then me$="identifier not defined !" : goto 58700
19440 gosub 54000
19450 gosub 56030
19460 be$=i1$ : ty%=3 : gosub 57000
19470 if sc=0 then me$= " identifier not defined ! " : goto 58700
19480 gosub 53000
19490 goto 5020

19500 rem assign
19510 va$= ""
19520 gosub 55000 : gosub 55000 : gosub 55000
19524 if i=41 then 19400
19530 gosub 56500 : va$=i1$
19535 gosub 55000 : gosub 55000
19540 if i<>49 then 19600
19550 va$=va$+"." : gosub 56500 : va$ =va$+i1$
19555 gosub 55000 : gosub 55000
19600 if i<>51 then 19900
19610 va$=va$+"e"
19620 gosub 55000 : gosub 55000
19630 if i=59 then 19700
19640 if i=52 then va$=va$+" +"
19650 if i=53 then va$=va$+"-"
19700 i1$=" " : gosub 56540
19710 va$=va$+i1$
19900 gosub 51000
19910 gosub 56000
19920 be$=i1$ : ty%=3 : gosub 57000
19930 if sc=o then me$=" identifier not defined !" : goto 58700
19940 d9=d9+1
19942 d9$=mid$(str$(d9) , 2 , len(str$(d9)) - 1)
19946 ou$="jmp de" +d9$ : gosub 59000
19950 ou$="dd"+d9$+" .m" : gosub 59000
19952 ou$=" .b"+str$(v0) : gosub 59000
19953 ou$=" .b"+str$(v1) : gosub 59000
19954 ou$=" .b"+str$(v2) : gosub 59000
19955 ou$=" .b"+str$(v3) : gosub 59000
19956 ou$=" .b"+str$(v4) : gosub 59000
19960 ou$="de" +d9$+" .m" : gosub 59000
19962 hi$=be$ : be$="dd" +d9$ : gosub 54000
19970 be$=hi$ : gosub 53000
19980 goto 5020

20000 rem add
20010 gosub 56000
20020 be$=i1$ : ty%=3 : gosub 57000
20030 if sc=0 then me$ ="identifier not defined !" goto 58700
20040 gosub 54000
20050 gosub 56030
20060 be$=i1$ : ty%=3 : gosub 57000
20070 if sc=0 then me$="identifier not defined !" : goto 58700
20080 ou$= "ldy #hb-"+be$ : gosub 59000
20090 ou$= "lda #lb-"+be$ : gosub 59000
20100 ou$= "jsr $b867" : gosub 59000
20110 gosub 56030
20120 be$=i1$ : ty%=3 : gosub 57000
20130 if sc=0 then me$="identifier not defined !" : goto 58700
20140 gosub 53000
20150 goto 5020

20500 rem subtract
20510 gosub 56000
20520 be$=i1$ : ty%=3 : gosub 57000
20530 if sc=0 then me$="identifier not defined !" : goto 58700
20540 gosub 54000
20550 gosub 56030
20560 be$=i1$ : ty%=3 : gosub 57000
20570 if sc=0 then me$="identifier not defined !" : goto 58700
20580 ou$="ldy #hb-"+be$ : gosub 59000
20590 ou$="lda #lb-"+be$ : gosub 59000
20600 ou$="jsr $b850" : gosub 59000
20610 gosub 56030
20620 be$=i1$ : ty%=3 : gosub 57000
20630 if sc=0 then me$="identifier not defined !" : goto 58700
20640 gosub 53000
20650 goto 5020
20920 ou$="jsr u-"+i1$ : gosub 59000

21000 rem multiply
21010 gosub 56000
21020 be$=i1$ : ty%=3 : gosub 57000
21030 if sc=0 then me$="identifier not defined !" : goto 58700
21040 gosub 54000
21050 gosub 56030
21060 be$=11$ : ty%=3 : gosub 57000
21070 if sc=0 then me$="identifier not defined !" : goto 58700
21080 ou$="ldy #hb-"+be$ : gosub 59000
21090 ou$="lda #lb-"+be$ : gosub 59000
21100 ou$="jsr $ba28" : gosub 59000
21110 gosub 56030
21120 be$=i1$ : ty%=3 : gosub 57000
21130 if sc=0 then me$="identifier not defined !" : goto 58700
21140 gosub 53000
21150 goto 5020

21500 rem divide
21510 gosub 56000
21520 be$=i1$ : ty%=3 : gosub 57000
21530 if sc=0 then me$="identifier not defined !" : goto 58700
21540 hi$=be$
21550 gosub 56030
21560 be$=i1$ : ty%=3 : gosub 57000
21570 if sc=0 then me$="identifier not defined !" : goto 58700
21575 gosub 54000
21580 ou$="ldy #hb-"+hi$ : gosub 59000
21590 ou$="lda #lb-"+hi$ : gosub 59000
21600 ou$="jsr $bbof" : gosub 59000
21610 gosub 56030
21620 be$=i1$ : ty%=3 : gosub 57000
21630 if sc=0 then me$="identifier not defined !" : goto 58700
21640 gosub 53000
21650 goto 5020

22000 rem power
22010 gosub 56000
22020 be$=i1$ : ty%=3 : gosub 57000
22030 if sc=0 then me$="identifier not defined !" : goto 58700
22040 gosub 52000
22050 gosub 56030
22060 be$=i1$ : ty%=3 : gosub 57000
22070 if sc=0 then me$="identifier not defined !" : goto 58700
22080 gosub 54000
22090 ou$= "jsr $bf7b" : gosub 59000
22110 gosub 56030
22120 be$=i1$ : ty%=3 : gosub 57000
22130 if sc=0 then me$="identifier not defined !" : goto 58700
22140 gosub 53000
22150 goto 5020

22500 rem generate
22510 gosub 56000
22520 ff$=""
22530 if i1$="absolute" then ff$="$bc58"
22540 if i1$="arctangent" then ff$="$e30e"
22550 if i1$="cosine" then ff$="$e264"
22560 if i1$="exponent" then ff$="$bfed"
22570 if i1$="integer" then ff$="$bccc"
22580 if i1$="logarithm" then ff$="$b9ea"
22590 if i1$="memoryvalue" then ff$="$b80d"
22600 if i1$="random" then ff$="$e097"
22610 if i1$="sign" then ff$="$bc39"
22620 if i1$="sine" then ff$="$e26b"
22630 if i1$="squareroot" then ff$="$bf71"
22640 if i1$="tangent" then ff$="$e2b4"
22650 if ff$="" then me$= "unknown function !" : goto 58700
22660 gosub 56030
22670 be$=i1$ : ty%=3 : gosub 57000
22680 if sc=o then me$="identifier not defined !" : goto 58700
22690 gosub 54000
22700 ou$="jsr "+ff$ : gosub 59000
22705 gosub 55000 : gosub 55000
22710 if i=27 then 22800
22720 gosub 56000 : gosub 55000 : gosub 55000
22800 be$=i1$ : ty%=3 : gosub 57000
22810 if sc=0 then me$="identifier not defined !" : goto 58700
22820 gosub 53000
22830 goto 5000

23000 rem period

23500 rem decision
23505 ef=ef+1 : iz=iz+1 : i(iz)=ef
23506 ef$=mid$(str$(i(iz)),2,len(str$(i(iz))))
23510 gosub 56000
23520 be$=i1$ : ty%=3 : gosub 57000
23530 if sc=0 then me$="identifier not defined !" : goto 58700
23540 gosub 54000
23550 gosub 55000 : gosub 55000
23560 op=i
23570 gosub 56000
23580 be$=i1$ : ty%=3 : gosub 57000
23590 if sc=0 then me$="identifier not defined !" : goto 58700
23600 ou$="ldy #hb-"+be$ : gosub 59000
23610 ou$="lda #lb-"+be$ : gosub 59000
23620 ou$="jsr $bc5b" : gosub 59000
23630 if op=43 then ou$="cmp #0" : gosub 59000
23640 if op=43 then ou$="beq th"+ef$ : gosub 59000
23650 if op=44 then ou$="cmp #0" : gosub 59000
23660 if op=44 then ou$="bne th"+ef$ : gosub 59000
23670 if op=45 then ou$="cmp #$ff" : gosub 59000
23680 if op=45 then ou$="beq th"+ef$ : gosub 59000
23690 if op=46 then ou$="cmp #1" : gosub 59000
23700 if op=46 then ou$="bne th"+ef$ : gosub 59000
23710 if op=47 then ou$="cmp #1" : gosub 59000
23720 if op=47 then ou$="beq th"+ef$ : gosub 59000
23730 if op=48 then ou$="cmp #$ff" : gosub 59000
23740 if op=48 then ou$="bne th"+ef$ : gosub 59000
23800 ou$="jmp el"+ef$ : gosub 59000
23810 ou$="th"+ef$+" .m" : gosub 59000
23820 goto 5020

24000 rem else
24005 ef$=mid$(str$(i(iz)),2,len(str$(i(iz))))
24010 ou$="jmp en"+ef$ : gosub 59000
24020 ou$="el"+ef$+" .m" : gosub 59000
24030 goto 5000

24500 rem decision end
24510 ef$=mid$(str$(i(iz)),2,len(str$(i(iz))))
24520 ou$="en"+ef$+" .m" : gosub 59000
24525 iz=iz-1
24530 goto 5000

25000 rem infinite loop
25005 gosub 56000
25010 be$=i1$ : ty%=4 : gosub 57000
25020 if sc=1 then me$="loop identifier already defined !" : goto 58700
25030 gosub 57500
25035 ou$="e-"+be$+" .m" : gosub 59000
25040 goto 5020

25500 rem infinite loop end
25505 gosub 56000
25510 be$=i1$ : ty%=4 : gosub 57000
25520 if sc=0 then me$="loop identifier not defined !" : goto 58700
25530 ou$="jmp e-"+i1$ : gosub 59000
25535 ou$="ee-"+i1$+" .m" : gosub 59000
25540 goto 5020

26000 rem output
26005 gosub 56000
26010 be$=i1$ : ty%=4 : gosub 57000
26020 if sc=0 then me$="loop identifier not defined !" : goto 58700
26030 ss$=be$
26040 gosub 56030
26050 be$=i1$ : ty%=3 : gosub 57000
26060 if sc=0 then me$="identifier not defined !" : goto 58700
26070 gosub 54000
26080 gosub 55000 : gosub 55000
26090 op=i
26100 gosub 56000
26110 be$=i1$ : ty%=3 : gosub 57000
26120 if sc=0 then me$="identifier not defined !" : goto 58700
26130 ou$="ldy #hb-"+be$ : gosub 59000
26140 ou$="lda #lb-"+be$ : gosub 59000
26150 ou$="jsr $bc5b" : gosub 59000
26160 d9=d9+1
26170 d9$=mid$(str$(d9),2,len(str$(d9))-1)
26200 if op=43 then ou$="cmp #0" : gosub 59000
26210 if op=43 then ou$="bne sz-"+d9$ : gosub 59000
26220 if op=44 then ou$="cmp #0" : gosub 59000
26230 if op=44 then ou$="beq sz-"+d9$ : gosub 59000
26240 if op=45 then ou$="cmp #255" : gosub 59000
26250 if op=45 then ou$="bne sz-"+d9$ : gosub 59000
26260 if op=46 then ou$="cmp #1" : gosub 59000
26270 if op=46 then ou$="beq sz-"+d9$ : gosub 59000
26280 if op=47 then ou$="cmp #1" : gosub 59000
26290 if op=47 then ou$="bne sz-"+d9$ : gosub 59000
26300 if op=48 then ou$="cmp #255" : gosub 59000
26310 if op=48 then ou$="beq sz-"+d9$ : gosub 59000
26440 ou$="jmp ee-"+ss$ : gosub 59000
26450 ou$="sz-"+d9$+" .m" : gosub 59000
26480 goto 5020

26500 rem index loop
26510 gosub 56000
26520 be$=i1$ : ty%=3 : gosub 57000
26530 if sc=0 then me$="identifier not defined !" : goto 58700
26540 dx$=be$
26550 gosub 56030
26560 be$=i1$ : ty%=3 : gosub 57000
26570 if sc=0 then me$="identifier not defined !" : goto 58700
26580 ux$=be$
26590 gosub 56030
26600 be$=i1$ : ty%=3 : gosub 57000
26610 if sc=0 then me$="identifier not defined !" : goto 58700
26620 ox$=be$
26630 s$(sl)=dx$ : sl=sl+1
26640 goto 5020

27000 rem loop start
27010 be$=ux$ : gosub 54000
27020 be$=dx$ : gosub 53000
27030 ou$="ia-"+s$(sl-1)+" .m" : gosub 59000
27040 be$=dx$ : gosub 54000
27050 ou$="ldy #hb-"+ox$ : gosub 59000
27060 ou$="lda #lb-"+ox$ : gosub 59000
27070 ou$="jsr $bc5b" : gosub 59000
27080 d9=d9+1
27090 d9$=mid$(str$(d9),2,len(str$(d9))-1)
27100 ou$="cmp #1" : gosub 59000
27110 ou$="bne ia"+d9$ : gosub 59000
27120 ou$="jmp ie-"+s$(sl-1) : gosub 59000
27130 ou$="ia"+d9$+" .m" : gosub 59000
27140 ou$="lda #$e8" : gosub 59000
27150 ou$="ldy #$bf" : gosub 59000
27160 ou$="jsr $b867" : gosub 59000
27170 be$=dx$ : gosub 53000
27180 goto 5000

27500 rem index loop end
27505 ou$="jmp ia-"+s$(sl-1) : gosub 59000
27510 ou$="ie-"+s$(sl-1)+" .m" : gosub 59000
27520 sl=sl-1
27530 goto 5000

28000 rem jumplabel
28010 gosub 56000
28020 ou$="s-"+i1$+" .m"
28030 goto 5020

28500 rem jump
28510 gosub 56000
28520 ou$="jmp s-"+i1$ : gosub 59000
28530 goto 5020

29000 rem call
29010 gosub 56000
29020 ou$="jsr u-"+i1$ : gosub 59000
29030 goto 5020

30000 rem line number
30010 if sp=1 then ou$="jsr spur" : gosub 59000
30020 get#in,i$ : if i$="" then i$=chr$(0)
30030 if sp=1 then ou$="ldx #"+str$(asc(i$)) : gosub 59000
30040 get#in,i$ : if i$="" then i$=chr$(0)
30050 if sp=1 then ou$="lda #" +str$(asc(i$)) : gosub 59000
30060 if sp=1 then ou$="jsr $bdcd" : gosub 59000
30070 goto 5000

31000 rem program end
31010 print#ou,chr$(0)chr$(0);
31020 close ou
31030 close in
31040 close 15
31050 close pr
31055 print
31060 print "end of the semantic  analysis."
31065 print
31070 print "the assembler can be loaded with  :"
31080 print "load"+chr$(34)+"assembler"+chr$(34)+",8"
31085 print
31090 print "the assembly language program can be loaded with :"
31100 print "load"+chr$(34)+"mini-src"+chr$(34)+",8"
31110 end

51000 rem convert number in va$ to internal representation
51005 if val(va$)=0 then goto 51200
51010 v1=0:v5=0:v6=129:v7=val(va$):ifv7<0thenv1=128:v7=abs(v7)
51020 if v7<1 and v7<>0 then v6=v6-1 : v7=v7*2 : goto 51020
51030 v8=v7
51040 if v8>=2 then v8=int(v8/2) : v5=v5+1 : goto 51040
51050 v0=v5+v6
51060 v7=(v7-2^v5)/2^v5
51070 v7=v7*128 :v1=v1+int(v7) :v7=v7-int(v7)
51080 v7=v7*256 :v2=int(v7) :v7=v7-v2
51090 v7=v7*256 :v3=int(v7) :v7=v7-v3
51100 v7=v7*256 :v4=int(v7) :v7=v7-v4
51110 return
51200 v0=0 :v1=0 :v2=0 :v3=0 :v4=0 : return

52000 rem put variable in arg
52010 ou$="lda #lb-" +be$ : gosub 59000
52020 ou$="ldy #hb-" +be$ : gosub 59000
52030 ou$="jsr $ba8c" : gosub 59000
52040 return

53000 rem load variable with fac
53010 ou$="ldx #lb-"+be$ : gosub 59000
53020 ou$="ldy #hb-"+be$ : gosub 59000
53030 ou$="jsr $bbd4" : gosub 59000
53040 return

54000 rem put variable in fac
54010 ou$="lda #lb-"+be$ : gosub 59000
54020 ou$="ldy #hb-"+be$ : gosub 59000
54030 ou$="jsr $bba2" : gosub 59000
54040 return

55000 rem place next symbol
55010 get#in,i$ : if i$="" then i=0 : return
55020 i=asc(i$) : return

56000 rem identifier expected
56005 i1$=""
56010 gosub 55000
56020 if i<>255 then me$="new symbol expected !" : gosub 58500 : return
56030 gosub 55000
56040 i1$="" : if i<>55 then me$="identifier expected !" : gosub 58500 : return
56050 gosub 55000
56060 if i=255 then return
56070 i1$=i1$+i$ : goto 56050

56300 rem string expected
56305 i1$=""
56310 gosub 55000
56320 if i<>255 then me$="new symbol expected !" : gosub 58500 : return
56330 gosub 55000
56340 if i<>57 then me$ ="string expected!" : gosub 58500 : return
56350 gosub 55000
56360 if i=255 then return
56370 i1$=i1$+i$ : goto 56050

56500 rem integer expected
56505 i1$=""
56510 gosub 55000
56520 if i<>255 then me$="new symbol expected !" : gosub 58500 : return
56530 gosub 55000
56540 if i<>59 then me$="integer expected !" : gosub 58500 : return
56550 gosub 55000
56560 if i=255 then return
56570 i1$=i1$+i$ : goto 56050

57000 rem identifier not yet defined ?
57005 sc=0
57010 for t=0 to l
57020 if b$(t)=be$ then if t%(t)=ty% then sc=1
57030 next t
57040 return

57500 rem enter identifier
57510 b$(l)=be$ : t%(l)=ty%
57520 l=l+1
57530 return

58000 rem wait after error
58010 print#pr,chr$(13)
58020 print#pr,me$
58030 print#pr,chr$(13)
58040 print#pr,"press <return>."
58050 get w$ : if w$<>chr$(13) then 58050
58060 goto 5000

58500 rem wait after error
58510 print#pr,chr$(13)
58520 print#pr,me$
58530 print#pr,chr$(13)
58540 print#pr,"press <return>."
58550 get w$ : if w$<>chr$(13) then 58550
58560 return

58700 rem wait after error
58710 print#pr,chr$(13)
58720 print#pr,me$
58730 print#pr,chr$(13)
58740 print#pr,"press <return>."
58750 get w$ : if w$<>chr$(13) then 58750
58760 goto 5020

59000 rem output of ou$ on ou
59010 pc=pc+len(ou$)+5
59020 p1=int(pc/256)
59030 p2=pc-p1*256
59040 zl=zl+10
59050 z1=int(zl/256)
59060 z2=zl-z1*256
59070 print#ou,chr$(p2)chr$(p1)chr$(z2)chr$(z1);ou$;chr$(0);
59080 print#pr,str$(zl)+" "+ou$
59090 ou$=""
59100 return

60000 rem read error channel
60010 input#15,en,em$,et,es : if en=o then return
60020 print#pr,chr$(13)chr$(13)
60030 print#pr,"error on diskette !"
60040 print#pr,"error report : ";em$
60050 print#pr,"error number : ";en
60060 print#pr,"track : ";et
60070 print#pr,"sector : ";es
60080 print#pr,"program stopped !"
60090 close pr
60100 close in
60110 close ou
60120 close 15
60130 end

61000 open 8,8,8,"mini-syn,s,r"
61010 open 4,4
61020 get#8,i$ : if st=64 then 61100
61025 if i$="" then i=0 : goto 61040
61030 i=asc(i$)
61040 print#4,i;
61050 goto 61020
61100 close8 : close4
