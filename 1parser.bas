!- 4.8 THE PARSER LISTING

10   rem program for the lexical analysis
20   rem and syntantical analysis
30   rem of mini programs
40   rem
50   rem declarations
60   rem
80   fl=8 : rem floppy device
90   be=15 : rem floppy command channel
100  in=8 : rem source input channel
110  ou=7 : rem binary output channel
120  pr=3 : rem printout device
130  i1$="" : i2$=" " : i3$="" : rem input buffer (chr$)
140  i1=0 : i2=0 : i3=0 : rem input buffer (asc)
150  en=0 : em$= "" : et=0 : es=0
180  t$="" : t=0
190  a=0 : b=0 : c=0 : d=0
210  z=0 : z%=0 : rem local variables
220  sg=1000 : rem stack size
270  t9=0 : rem local loop index
280  tl=1 : g$="" : g=0
290  o=0 : rem top stack symbol
300  bu$="" : rem variable for action
310  fe=0 : rem error variable
320  zn=0 : rem flag for start of line
330  g=0  : rem current char or MINI symbol

400  rem vars related to arrays below
410  s=0 : rem stack pointer
420  al=1 : rem pointer to current alternative
430  al%=0 : rem length of al$(al)
440  ba%=85 : rem max index of ba$()

500  rem arrays allocated last
510  dim ba$(ba%) : rem test basic words
520  dim mi$(48) : rem text mini words
530  dim al$(69) : rem grammar rules
540  dim s%(sg) : rem stack

1000 rem --
1010 rem preparations
1020 rem --

1040 printchr$(147);chr$(14)
1050 print:print"the mini-compiler :":print
1060 print"send to printer or screen? (p/s)?"
1070 get i1$ : if i1$="p" or i1$="s" then 1090
1080 goto 1070
1090 if i1$="p" then pr=4
1100 open pr,pr,7 : rem open output channel
1110 print:print"please insert data disk"
1120 print
1130 rem
1140 print "name of program to be compiled"
1150 input "name "; i2$
1160 open be,fl,be
1170 print#be,"i"

1180 print#be,"s:mini-syn"
1190 input#be,en,em$,et,es
1210 open in,fl,in,"0:"+i2$+",p,r" : gosub 60000
1220 get#in,i1$,i1$
1230 open ou,fl,ou,"0:mini-syn,s,w" : gosub 60000
1240 gosub 59000
1245 gosub 58000
1250 gosub 51500 : gosub 51500 : gosub 51000
1260 gosub 49000 : rem grammar load
1270 gosub 42000 : rem place first character
1280 gosub 41000 : rem load first alternative

2000 rem parser loop
2010 o=s%(s)
2020 al=255
2030 if o=251 then goto 38000
2040 if o=252 then goto 39000
2050 if o=253 then goto 10000
2060 if s%(s)=255 and g=255 then goto 35000
2070 if s%(s)=g then gosub 40000 : gosub 42000 : goto 2000
2080 print#pr,chr$(13)"error !"
2085 if s%(s)=255 then print#pr,"eof expected."
2086 if s%(s)=255 then print#pr,"i am ending the program." : goto 35000
2090 if s%(s)>127 then print#pr,"the word '";mi$(s%(s)-128);"' expected."
2100 if s%(s)<128 then print#pr,"the word '";s;"' expected ."
2110 goto 10400

10000 rem search for alternative
10010 o=s%(s-1)
10020 gosub 11000
10025 if al=255 then goto 10040
10030 if len(al$(al))<>0 then gosub 40000 : gosub 41000 : goto 2000
10035 gosub 41000 : goto 2000
10040 print#pr,chr$(13)
10050 print#pr,"error: ";
10060 print#pr,"no alternative possible !"
10070 print#pr,"one of the following symbols expected:"
10080 if o=1oro=2oro=3 then print#pr,"  empty write writeln linefeed border"
10090 if o=1oro=2oro=3 then print#pr,"  cuscol curslin writeas outputdevice"
10100 if o=1oro=2oro=3 then print#pr,"  clearscreen background type get"
10110 if o=1oro=2oro=3 then print#pr,"  assign add subtract"
10120 if o=1oro=2oro=3 then print#pr,"  multiply divide power"
10130 if o=1oro=2oro=3 then print#pr,"  generate if loop exit for"
10140 if o=1oro=2oro=3 then print#pr,"  jumplabel jump call"
10150 if o=4 or o=5 or o=24 or o=6 or o=17 or o=25 then print#pr,"  letter"
10160 if o=24 or o=15 then print#pr,"  = /= < <= > >="
10170 if o=24 then print#pr,"  is and of with by over if to"
10180 if o=24 then print#pr,"  repeat then"
10190 if o=24 or o=20 then print#pr, "  ,"
10200 if o=24 or o=20 or o=3 or o=6 or o=23 or o=12 then print#pr,"  ."
10210 if o=16 then print#pr,"  program"
10220 if o=18 then print#pr,"  subroutine eof"
10230 if o=7 or o=19 then print#pr, "  float"
10240 if o=8 then print#pr,"  begin"
10250 if o=17 or o=14 or o=23 or o=22 or o=11 or o=10 then print#pr,"  digit"
10260 if o=6 or o=23 or o=12 or o=13 then print#pr,"  tovar"
10270 if o=3 then print#pr,"  pend srend else endif lend"
10280 if o=21 then print#pr,"  keyboard character without quote marks"
10290 if o=21 or o=25 then print#pr,"  quotation mark"
10300 if o=23 or o=12 or o=13 or o=9 then print#pr,"  e" 
10310 if o=10 then print#pr,"  + -"

10400 fe=fe+1
10405 print#pr,
10410 print#pr,"the following symbol is also expected:"
10420 if s%(s)>250 and s>=2 then s=s-2 : goto 10420
10430 if s<=0 then 35000
10440 if s%(s)>127 then print#pr,"  ";mi$(s%(s)-128)
10450 if s%(s)<128 then print#pr,"  ";s
10460 print#pr,"press <return>"
10470 get em$ : if em$<>chr$(13) then 10470
10480 print#pr,"searching program ";
10490 if s%(s)>127 then print#pr,mi$(s%(s)-128);
10500 if s%(s)<128 then print#pr,s;
10510 print#pr," appears."
10520 print#pr,"searching highest to next period"
10530 print#pr,"or start of line."
10540 if nz<>1 then if g<>46 then if g<>s%(s) then gosub 42000 : goto 10540
10545 print#pr,
10550 if nz=1 then print#pr,"i have read up to the next line!"
10560 if g=s%(s) and s%(s)>127 then print#pr,"found ";mi$(s%(s)-128)
10570 if g=s%(s) and s%(s)<128 then print#pr,"found ";s
10580 if g=s%(s) then print#pr,"continuing the syntactic check."
10590 if g=s%(s) then gosub 40000 : gosub 42000 : goto 2000
10600 if g=46 then print#pr,"i have read up to the next period."
10610 print#pr,"trying to restart and"
10620 print#pr,"continue with syntactic"
10630 print#pr,"check."
10640 if s%(s)>250 and s>=2 then s=s- 2 : goto 10640
10650 if s<=0 then 35000
10660 if s%(s)<>46 then s=s-1 : goto 10640
10670 gosub 42000 : gosub 40000 : goto 2000

#region 11000-15000 do alternatives
11000 rem branch to the alternatives
11010 on int(o/10) goto 11030, 11040
11020 on o goto 12100,12200,12300,12400,12500,12600,12700,12800,12900
11030 on o-9 goto 13000,13100,13200,13300,13400,13500,13600,13700,13800,13900
11040 on o-19 goto 14000,14100,14200,14300,14400,14500,14600
11050 print#pr, chr$(13) "this rule doesn't exist! "
11060 stop

12000 rem selection of the alternative
12100 rem /01/ instruction
12105 if g=142 then al=15 : return
12110 if g=167 then al=16 : return
12115 if g=168 then al=17 : return
12120 if g=164 then al=18 : return
12125 if g=152 then al=19 : return
12130 if g=133 then al=20 : return
12135 if g=134 then al=21 : return
12140 if g=169 then al=22 : return
12145 if g=129 then al=23 : return
12150 if g=149 then al=24 : return
12155 if g=139 then al=25 : return
12157 if g=151 then al=26 : return
12160 if g=140 then al=27 : return
12162 if g=160 then al=28 : return
12164 if g=128 then al=29 : return
12166 if g=158 then al=30 : return
12168 if g=144 then al=31 : return
12170 if g=137 then al=32 : return
12172 if g=147 then al=33 : return
12174 if g=132 then al=34 : return
12176 if g=166 then al=35 : return
12178 if g=153 then al=36 : return
12180 if g=130 then al=37 : return
12182 if g=171 then al=38 : return
12184 if g=157 then al=39 : return
12186 if g=156 then al=40 : return
12188 if g=150 then al=41 : return
12190 return

12200 rem /02/ instruction block
12210 gosub 12100
12220 if al<>255 then al=12
12230 return

12300 rem /03/ instruction set
12310 gosub 12100
12320 if g=146 then   al=14 : return
12330 if g=161 then   al=14 : return
12340 if g=155 then   al=14 : return
12350 if g=165 then   al=14 : return
12360 if g=46  then   al=14 : return
12370 if g=154 then   al=14 : return
12380 if al<>255 then al=13 : return
12390 return

12400 rem /04/ condition
12410 if g>64 and g<91 then al=46
12420 return

12500 rem /05/ identifier
12510 if g>64 and g<91 then al=4
12520 return

12600 rem /06/ generate-1
12610 if g=145 then al=44 : return
12620 if g=46 then al=45 : return
12630 return

12700 rem /07/ letter
12710 al=6
12720 return

12800 rem /08/ definition block
12810 if g=138 then al=7
12820 if g=131 then al=8
12830 return

12900 rem /09/ exponent
12910 if g=69 then al=64
12920 return

13000 rem /10/ exponent-1
13010 if g=43 then al=65
13020 if g=45 then al=66
13030 if g>47 and g<58 then al=67
13040 return

13100 rem /11/ floating-point number
13110 if g>47 and g<58 then al=58
13120 return

13200 rem /12/ floating-point number 1
13210 if g=46 then al=59
13220 if g=69 then al=60
13230 if g=145 then al=61
13240 return

13300 rem /13/ floating-point number 2
13310 if g=69 then al=62
13320 if g=145 then al=63
13330 return

13400 rem /14/ integer
13410 if g>47 and g<58 then al=55
13420 return

13500 rem /15/ operator
13510 if g=61 then al=47 : return
13520 if g=174 then al=48 : return
13530 if g=60 then al=49 : return
13540 if g=175 then al=50 : return
13550 if g=62 then al=51 : return
13560 if g=176 then al=52 : return
13570 return

13600 rem /16/ program
13610 if g=148 then al=1
13620 return

13700 rem /17/ assign- 1
13710 if g>47 and g<58 then al=42 : return
13720 if g>64 and g<91 then al=43
13730 return

13800 rem /18/ subroutine
13810 if g=162 then al=2
13820 if g=255 then al=3
13830 return

13900 rem /19/ variable definition
13910 if g=138 then al=9
13920 return

14000 rem /20/ variable definition-2
14010 if g=44 then al=10
14020 if g=46 then al=11
14030 return

14100 rem /21/ string
14110 if g<>34 then al=53
14120 if g=34 then al=54
14130 return

14200 rem /22/ digit
14210 al=57
14220 return

14300 rem /23/ integer-1
14310 if g>47 and g<58 then al=55
14320 if g=46 or g=69 or g=145 then al=56
14330 return

14400 rem /24/ identifier-1
14410 if g>64 and g<91 then al=4 : return
14420 if g=141 or g=46 or g=44 or g=170 or g=145 then al=5 : return
14430 if g=163 or g=143 or g=136 or g=159 or g=166 then al=5 : return
14440 if g=172 or g=173 or g=135 or g=174 or g=175 then al=5 : return
14450 if g=176 or g=60 or g=61 or g=62 then al=5 : return
14460 return

14500 rem /25/ write-1
14510 if g=34 then al=68 : return
14520 if g>64 and g<91 then al=69 : return
14530 return

14600 rem /26/ keyboard character
14610 if g<>34 then al=57 : return
14620 al=6
14630 return
#endregion

35000 rem program end
35010 print#pr,chr$(13)chr$(13)"syntactic check completed."
35020 if fe<>0 then print#pr,fe; " errors found."
35030 if fe=0 then print#pr,chr$(13)"program  syntactic correct."
35040 print#ou,chr$(255)chr$(255);
35050 close pr : close in : close ou : close be
35060 end

38000 rem output foot semantic
38010 if s%(s-1)=54 then bu$=bu$+g$ : gosub 40000 : gosub 42000 : goto 2000
38020 if s%(s-1)=56 then bu$=bu$+g$ : gosub 40000 : gosub 42000 : goto 2000
38030 if s%(s-1)=58 then bu$=bu$+g$ : gosub 40000 : gosub 42000 : goto 2000
38040 if s%(s-1)=55 then print#ou,chr$(255)chr$(55);bu$; : bu$="" : gosub 40000
38050 if s%(s-1)=57 then print#ou,chr$(255)chr$(57);bu$; : bu$="" : gosub 40000
38060 if s%(s-1)=59 then print#ou,chr$(255)chr$(59);bu$; : bu$="" : gosub 40000
38070 goto 2000

39000 rem output fgfor semantic
39010 print#ou,chr$(255)chr$(253)chr$(s%(s-1));
39020 gosub 40000
39030 goto 2000

40000 rem removing the top symbols
40010 if s%(s)=253 then s=s-2 : return
40020 if s%(s)=252 then s=s-2 : return
40030 if s%(s)=251 then s=s-2 : return
40040 s=s-1 : return

41000 rem write alternative on the stack
41010 al%=len(al$(al))
41020 if al%=0 then gosub 40000 : return
41025 s=s+1
41030 for t9=al% to 1 step -1
41040 s%(s)=asc(mid$(al$(al),t9,1)) : s=s+1
41050 next t9
41060 s=s-1
41065 rem print#pr,chr$(13)chr$(13) : forl=sto0step -1:print#pr,s%(l);:next
41070 return

42000 rem place a new character
42010 if tl>len(t$) then t$="" : gosub 50000 : tl=1
42020 g$=mid$(t$,tl,1) : g=asc(g$)
42030 tl=tl+1
42035 rem print#pr,chr$(13)"the current character:";g
42037 rem print#pr,chr$(13)"t$= ";t$
42040 return

#region 49000 data-grammar
49000 rem the grammar
49010 data 148,252,1,253,5,141,252,2,253,8,252,3
49012 data 131,253,2,146,252,4,253,5,46,253,18,252,5,255,250
49020 data 162,252,6,253,5,141,253,2,161,252,7,253,5,46,253,18,250
49030 data 250
49040 data 251,54,253,7,253,24,250
49050 data 251,55,250
49060 data 250
49070 data 253,19,250
49080 data 250
49090 data 138,253,5,253,20,46,253,8,250
49100 data 44,253,5,253,20,250
49110 data 250
49120 data 253,1,253,3,250
49130 data 253,1,253,3,250
49140 data 250
49150 data 142,46,250
49160 data 252,8,167,253,25,46,250
49170 data 252,9,168,253,25,46,250
49180 data 252,10,164,46,250
49190 data 252,11,152,46,250
49200 data 252,12,133,253,14,46,250
49210 data 252,13,134,253,14,46,250
49220 data 252,14,169,253,14,46,250
49230 data 252,15,129,253,5,46,250
49240 data 252,16,149,253,5,46,250
49250 data 252,17,139,253,5,46,250
49260 data 252,18,151,253,5,46,250
49270 data 252,19,140,253,5,46,250
49280 data 252,20,160,253,17,46,250
49290 data 252,21,128,253,5,170,253,5,145,253,5,46,250
49300 data 252,22,158,253,5,163,253,5,145,253,5,46,250
49310 data 252,23,144,253,5,143,253,5,145,253,5,46,250
49320 data 252,24,137,253,5,136,253,5,145,253,5,46,250
49330 data 252,25,147,253,5,143,253,5,145,253,5,46,250
49340 data 252,26,132,253,5,163,253,5,253,6,252,27,46,250
49350 data 252,28,166,253,4,135,253,2,252,29,155,253,2
49355 data 165,252,30,46,250
49360 data 252,31,153,253,5,159,253,2,154,252,32,253,5,46,250
49370 data 252,33,130,253,5,166,253,4,46,250
49380 data 252,34,171,253,5,163,253,5,172,253,5,173
49385 data 252,35,253,2,154,252,36,46,250
49390 data 252,37,157,253,5,46,250
49400 data 252,38,156,253,5,46,250
49410 data 252,39,150,253,5,46,250
49420 data 252,40,253,11,145,253,5,250
49430 data 252,41,253,5,145,253,5,250
49440 data 252,42,145,253,5,250
49450 data 250
49460 data 253,5,253,15,253,5,250
49470 data 252,43,61,250
49480 data 252,44,174,250
49490 data 252,45,60,250
49500 data 252,46,175,250
49510 data 252,47,62,250
49520 data 252,48,176,250
49530 data 251,56,253,26,253,21,250
49540 data 251,57,250
49550 data 251,58,253,22,253,23,250
49560 data 251,59,250
49570 data 250
49580 data 253,14,253,12,250
49590 data 252,49,46,253,14,253,13,250
49600 data 253,9,250
49610 data 252,50,250
49620 data 253,9,250
49630 data 252,50,250
49640 data 252,51,69,253,10,250
49650 data 252,53,43,253,14,250
49660 data 252,53,45,253,14,250
49670 data 253,14,250
49680 data 34,253,21,34,250
49690 data 253,5,250

49800 for z=1 to 69
49810 read z% : if z%<>250 then al$(z)=al$(z)+chr$(z%) : goto 49810
49820 next
49830 return
#endregion

50000 rem lexical analysis
50005 zn=0
50010 if i1=0 then if i2=0 then if i3=0 then t$=chr$(255) : return
50020 if i1=0 then gosub 51000
50030 if i1>127 and i1<129+ba% then i1$=ba$(i1-128)
50040 if i1=171 then if i2=171 then gosub 51700 : goto 50000
50050 if i1$=" " then if i2$=" " then print#pr,i1$; : gosub 51500 : goto 50000
50070 if i1$="<" and i2=178 then t$=chr$(175) : goto 50195
50072 if i1$=">" and i2=178 then t$=chr$(176) : goto 50195
50074 if i1$="/" and i2=178 then t$=chr$(174) : goto 50195
50080 if i1=34 then gosub 53000 : goto 50210
50085 if i1=32 then if i2=34 then goto 50130
50090 if i2$="=" or i2$="/" or i2$="<" or i2$=">" then gosub 52000 : goto 50200
50100 if i2$="." or i2$=" " or i2=0 or i2=34 then gosub 52000 : goto 50200
50110 if i2$="," then gosub 52000 : goto 50200
50126 if i1$="." or i1$="," or il$="=" then t$=i1$ : goto 50200
50128 if i1$="/" or i1$="<" or i1$=">" then t$=i1$ : goto 50200
50130 if i1$=" " then print#pr," "; : gosub 51500 : goto 50000
50190 t$=t$+i1$ : print#pr,i1$; : gosub 51500 : goto 50000
50195 print#pr,i1$; : gosub 51500
50197 if i1>127 and i1<129+ba% then i1$=ba$(i1-128)
50200 print#pr,i1$; : gosub 51500
50210 return

51000 rem start of line
51007 zn=1
51010 gosub 51500 : gosub 51500 : gosub 51500
51020 print#ou,chr$(255)chr$(254)chr$(i1)chr$(i2);
51030 print#pr,chr$(13);str$(i1+i2*256);" ";
51040 gosub 51500 : gosub 51500 : return

51500 rem read character
51510 i1$=i2$ : i2$=i3$ : get#in,i3$
51520 i1=i2 : i2=i3 : if i3$="" then i3=0 : return
51530 i3=asc(i3$) : return

51700 rem skip line to end
51710 print#pr,i1$; : gosub 51500 : if i1=0 then return
51720 if i1>127 and i1<129+ba% then i1$=ba$(i1- 128)
51730 goto 51710

52000 rem is t$ a token?
52020 t$=t$+i1$ : t=0 : a=asc(left$(t$,1))
52030 if a<65 or a>90 then return
52035 d=0 : c=45 : gosub52700 : return

52700 for d=b to c
52710 if t$=mi$(d) then t=128+d
52720 next d
52800 if t=0 then return
52810 t$=chr$(t) : return
52900 return

53000 rem skip string
53010 t$=t$+i1$ : print#pr,i1$; : gosub 51500 : if i1<>34 then goto 53010
53020 t$=t$+i1$ : print#pr,i1$; : gosub 51500 : return

#region 58000,59000 data-words
58000 rem mini words
58008 mi$(0)="add"
58009 mi$(42)="and"
58010 mi$(32)="assign"
58020 mi$(11)="background"
58030 mi$( 3)="begin"
58035 mi$(21)="border"
58040 mi$( 8)="by"
58042 mi$(22)="call"
58045 mi$(24)="clearscreen"
58050 mi$( 5)="curscol"
58060 mi$( 6)="curslin"
58090 mi$( 9)="divide"
58091 mi$(27)="else"
58093 mi$(14)="empty"
58094 mi$(37)="endif"
58099 mi$(2)= "exit"
58100 mi$(10)="float"
58106 mi$(35)="from"
58112 mi$( 4)="generate"
58120 mi$(12)="get"
58121 mi$(38)="if"
58130 mi$(13)="is"
58132 mi$(28)="jump"
58134 mi$(29)="jumplabel"
58140 mi$(26)="lend"
58145 mi$(36)="linefeed"
58150 mi$(25)="loop"
58160 mi$(16)="multiply"
!- 58161 mi$(35)="of"
58162 mi$(31)="over"
58163 mi$( 1)="outputdevice"
58180 mi$(18)="pend"
58190 mi$(19)="power"
58200 mi$(20)="program"
58270 mi$(33)="srend"
58280 mi$(34)="subroutine"
58290 mi$(30)="subtract"
58292 mi$( 7)="then"
58296 mi$(17)="tovar"
58299 mi$(23)="type"
58388 mi$(15)="with"
58390 mi$(39)="write"
58400 mi$(40)="writeln"
58410 mi$(41)="writeas"
58430 mi$(43)="for"
58440 mi$(44)="to"
58450 mi$(45)="repeat"
58460 mi$(46)="/="
58470 mi$(47)="<="
58480 mi$(48)=">="
58490 return

59000 rem basic-words
59008 ba$(0)="end"
59010 ba$(1)="for"
59020 ba$(2)="next"
59030 ba$(3)="data"
59040 ba$(4)="input#"
59050 ba$(5)="input"
59060 ba$(6)="dim"
59070 ba$(7)="read"
59080 ba$(8)="let"
59090 ba$(9)="goto"
59100 ba$(10)="run"
59110 ba$(11)="if"
59120 ba$(12)="restore"
59130 ba$(13)="gosub"
59140 ba$(14)="return"
59150 ba$(15)="rem"
59160 ba$(16)="stop"
59170 ba$(17)="on"
59180 ba$(18)="wait"
59190 ba$(19)="load"
59200 ba$(20)="save"
59210 ba$(21)="verify"
59220 ba$(22)="def"
59230 ba$(23)="poke"
59240 ba$(24)="print#"
59250 ba$(25)="print"
59260 ba$(26)="cont"
59270 ba$(27)="list"
59280 ba$(28)="clr"
59290 ba$(29)="cmd"
59300 ba$(30)="sys"
59310 ba$(31)="open"
59320 ba$(32)="close"
59330 ba$(33)="get"
59340 ba$(34)="new"
59350 ba$(35)="tab("
59360 ba$(36)="to"
59370 ba$(37)="fn"
59380 ba$(38)="spc("
59390 ba$(39)="then"
59400 ba$(40)="not"
59410 ba$(41)="step"
59420 ba$(42)="+"
59430 ba$(43)="-"
59440 ba$(44)="*"
59450 ba$(45)="/"
59460 ba$(46)="a"
59470 ba$(47)="and"
59480 ba$(48)="or"
59490 ba$(49)=">"
59500 ba$(50)="="
59510 ba$(51)="<"
59520 ba$(52)="sgn"
59530 ba$(53)="int"
59540 ba$(54)="abs"
59550 ba$(55)="usr"
59560 ba$(56)="fre"
59570 ba$(57)="pos"
59580 ba$(58)="sqr"
59590 ba$(59)="rnd"
59600 ba$(60)="log"
59610 ba$(61)="exp"
59620 ba$(62)="cos"
59630 ba$(63)="sin"
59640 ba$(64)="tan"
59650 ba$(65)="atn"
59660 ba$(66)="peek"
59670 ba$(67)="len"
59680 ba$(68)="str$"
59690 ba$(69)="val"
59700 ba$(70)="asc"
59710 ba$(71)="chr$"
59720 ba$(72)="left$"
59730 ba$(73)="right$"
59740 ba$(74)="mid$"
59750 ba$(75)="go"

!- Extra tokens generated by CBM prg Studio
59800 ba$(82)="color"
59810 ba$(85)="char"

59990 return
#endregion

60000 rem read disk drive error channel
60020 input#be,en,em$,et,es : if en=0 then return
60030 print
60040 print "**** error on diskette!"
60050 print "**** error number : ";en
60060 print "**** error message :"
60070 print "**** ";em$
60080 print "**** track ";et
60090 print "**** sector ";es
60100 print#be,"i"
60110 close be : close pr
60120 print : print"**** program stopped!!!!! "
60130 end
