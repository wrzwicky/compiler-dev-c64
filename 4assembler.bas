!- 6.3 THE ASSEMBLER PROGRAM

45000 open15,8,15 : print#15,"i" : print chr$(14)
45010 print"{clear}{down*2}  ****    please insert data    ****"
45020 print"  ****          disk!           ****"
45030 print"  ****   press      < return >  ****"
45040 get f$:iff$<>chr$(13) then 45040
45050 print#15,"i"
45070 input#15,en,em$,et,es
45100 if en<>0 then goto 45010
45110 close15
45120 goto 49999

48000 rem **** disk error
48010 print "{down*2}  ****   press      < return >  ****"
48020 get w$:if w$<>chr$(13) then 48020
48025 close 8 : close 9 : close 15
48030 end : rem sys 2076

49999 rem
50000 rem************* assemble
50001 open 15,8,15 : print#15,"i"
50002 dimf$(150),l$(500),l(500),n$(200),n(200),s$(400),s(400)
50003 l=2 : f=0 : pc=2129 : pm=pc : n=0 : s=0 : l$(0)="ch" : l$(1)= "cl" : po=0
50004 ti$="000000"
50005 print "{down}name of source program :"
50006 input na$
50007 for t=2 to len(na$) : if mid$(na$,t,1)<>" " then next
50008 na$=left$ (na$, t-1) : print"{clear}"
50010 gosub 60000
50011 open 8,8,8,"0:"+na$+",p,r" : gosub 50800 : if en<>0 then 48000
50012 get#8,g$,h$ : if st<>0 then 48000
50014 g=asc(g$) : h=asc(h$)
50016 ad=g+256*h : a1=ad-2 : goto 50500
50020 gosub 50400
50030 if p=0 then goto 50500
50050 if p=59 then print"comment  ";: goto 50500
50060 if p=32 then goto 50700
50065 if p=34 then 50420

50070 rem **** missing line!

50240 if p>127 and p<204 then goto 51000
50250 if p<128 and p>32 then b$=b$+chr$(p)
50260 goto 50020

50400 g=h:p=g:a1=a1+1:get#8,h$:ifst<>0thenprint:print".end forgotten?":goto62300
50405 if h$="" then h=0 : goto 50415
50410 h=asc(h$)
50415 return

50420 b$=b$+chr$(p)
50430 gosub 50400 : if p=34 then b$=b$+chr$(p) : goto 50020
50440 if p=0 then 50030
50450 goto 50420

50500 rem************* start of new line
50503 if b$<>"" then gosub 51200
50504 if t0$="1" then f=f+1:f$(f)=zn$+"  pseudo instruction expected":printf$(f)
50505 t0$="n" : f$="n" : ex=0
50507 if a1=ad then 50512
50510 a3=a1 : for a2=a3 to ad-1 : gosub 50400 : next a2
50512 ad=g+256*h
50515 gosub 50400 : gosub 50400
50527 zn=g+256*h : zn$="line : "+str$(zn)
50530 print : print"line :";zn;
50535 gosub 50400
50540 goto 50020

50700 rem************* blank found
50710 if b$="" then 50020
50712 if left$(b$,1)=chr$(34) then b$=b$+chr$(p) : goto 50020
50715 if b$="#" orb$="(" then 50020
50717 if h=32 then 50020
50718 if ex=1 then 50020
50719 if t0$<>"n" and h>169 and h<175 then gosub 50400 : ex=1 : goto 50070
50720 gosub 51200
50730 goto 50020

50800 rem ************ error channel
50810 input#15,en,em$,et,es : if en=0 then return
50820 print"{clear}{down*2}  ****    error on diskette  ****" : close 8
50830 print"  **** error number  : ";en
50840 print"  **** error message : ";em$
50850 print"  **** track         : ";et
50860 print"  **** sector        : ";es
50870 goto 62300

51000 rem************* convert interpreter code
51010 h$=""
51012 if p<140 then p9=41116 : p6=p-127 : goto 51020
51014 if p<160 then p9=41160 : p6=p-139 : goto 51020
51016 if p<180 then p9=41244 : p6=p-159 : goto 51020
51018 p9=49483-8192 : p6=p-179
51020 for t1=1 to p6
51030 p9=p9+1 : if peek(p9)<128 then 51030
51040 next t1
51050 p9=p9+1 : if peek(p9)<128 then h$=h$+chr$(peek(p9)) : goto 51050
51060 h$=h$+chr$(peek(p9)-128)
51090 b$=b$+h$
51095 goto 50020

51200 rem************* token found / evaluate
51203 printb$+" ";
51205 mn$="n"
51207 if t0$="i" then gosub 55400 : goto 51290
51208 if b$<>".varequ" and f$="d" then gosub 54580
51210 if left$(b$,1)="." then gosub 51400 : goto 51290
51220 if t0$="p" then gosub 54000 : goto 51290
51222 if t0$="r" then gosub 56500 : goto 51290
51225 if t0$="m" then gosub 54800 : goto 51290
51230 if len(b$)=3 and t0$="n" then gosub 53000
51240 if mn$="j" then goto 51290
51270 if t0$="1" then f=f+1:f$(f)=zn$+"  pseudo instruction expected":printf$(f)
51280 if t0$="n" then la$=b$ : t0$="1"
51290 b$=""
51300 return

51400 rem************* pseudo-operation found
51405 ps=0
51410 if b$=".end" then ps=1
51420 if b$=".equ" or b$=".e" then ps=2
51430 if b$=".start" then ps=3
51440 if b$=".block" or b$=".bl" then ps=4
51450 if b$=".byte" or b$=".b" then ps=5
51460 if b$=".dbyte" or b$ =".db" then ps=6
51470 if b$=".text" or b$=".t" then ps=7
51480 if b$=".word" or b$=".w" then ps=8
51490 if b$=".varequ" or b$=".v" then ps=9
51495 if b$=".marke" or b$=".m" then ps=10
51497 if b$=".count" or b$=".c" then ps=11
51500 onpsgosub51600,52000,52100,52200,52300,52400,52500,52600,52700,52800,52900
51510 if ps=0 then print "{down*2}**** no pseudo****"
51515 if ps<>0 then t0$="p"
51520 return

51600 rem************* pseudo-operation .end
51601 close 8 : gosub 50800
51602 print : print "{down*2}  ****  programm-length  ****"
51603 if p0=0 then print"  ****      ";pc-pm+2129-2047
51604 if p0=1 then print"  ****      ";pc-pm
51605 print"  ****      bytes      ****"
51606 gosub 61000
51610 print"{down*2}  **** end of ****"
51640 print"  **** error check ****"
51643 print"  **** press < return > ****"
51645 get w$ : if w$<>chr$(13) then 51645
51650 for t=1 to f
51660 print f$(t)
51670 for g=1 to 1000 : next
51680 next
51681 print" **** the machine language prg.":print" **** has the name "+na$+"-obj"
51685 goto 62300

52000 rem************* pseudo-operation .equ
52010 ps$="e"
52020 return

52100 rem************* pseudo-operation .start
52110 ps$="s"
52120 return

52200 rem************* pseudo-operation .block
52210 ps$="k"
52220 if la$<>"" then b$=la$ : gosub 54500
52230 if f$="d" then gosub 54580
52240 return

52300 rem************* pseudo-operation .byte
52310 ps$="b"
52320 if la$<>"" then b$=la$ : gosub 54500
52330 if f$="d" then gosub 54580
52340 return

52400 rem************* pseudo-operation .dbyte
52410 ps$="d"
52420 if la$<>"" then b$=la$ : gosub 54500
52430 if f$="d" then gosub 54580
52440 return

52500 rem************* pseudo-operation .text
52510 ps$="t"
52520 if la$<>"" then b$=la$ : gosub 54500
52530 if f$="d" then gosub 54580
52540 return

52600 rem*************  pseudo-operation .word
52610 ps$="w"
52620 if la$<>"" then b$=la$ : gosub 54500
52630 if f$="d" then gosub 54580
52640 return

52700 rem*************  pseudo-operation .varequ
52710 ps$="v" : f$="n"
52720 return

52800 rem*************  pseudo-operation .marke
52810 t0$="i" : b$=la$ : gosub 54500
52820 if f$="d" then gosub 54580
52830 return

52900 rem*************  pseudo-operation .count
52910 t0$="i"
52920 l(0)=int(pc/256) : l(1)=pc-l(0)*256
52930 return

53000 rem************* mnemonic assumed
53005 w=0
53010 t=62
53020 gosub 53700
53030 te$=left$(t$,3)
53035 rem printte$,b$
53040 if b$=te$ then w=val(mid$(t$,6,1)) : ts=t : goto 53570
53050 if b$<te$ then t=asc(mid$(t$,4,1)) : goto 53210
53060 t=asc(mid$(t$,5,1))
53210 if t=91 then w=0 : goto 53570
53220 goto 53020
53570 if w=0 then mn$="n" : return
53580 if w=1 then gosub 55500 : return
53590 if w=2 then gosub 55700 : return
53600 gosub 56000 : return

53700 rem*************  load tt with address t
53705 on int(t/10)-2 goto 53710,53720,53730,53740,53750,53760,53770
53710 on t-34 gosub 53801,53802,53803,53804,53805 : return
53720 on t-39 gosub 53806,53807,53808,53809,53810,53811,53812,53813,53814,53815 : return
53730 on t-49 gosub 53816,53817,53818,53819,53820,53821,53822,53823,53824,53825 : return
53740 on t-59 gosub 53826,53827,53828,53829,53830,53831,53832,53833,53834,53835 : return
53750 on t-69 gosub 53836,53837,53838,53839,53840,53841,53842,53843,53844,53845 : return
53760 on t-79 gosub 53846,53847,53848,53849,53850,53851,53852,53853,53854,53855 : return
53770 gosub 53856 : return

53801 t$="adc[[369[[[[1265#7k23275#8k3626d[[[[237d[[[[8379[[#59361[[[[4271[[[[52":return
53802 t$="and#%329[[[[1225[[j23235$8j3622d[[j4233d[[[[8339[[$59321?1[[4231[[[[52":return
53803 t$="asl[[30a[[[[:106[[[[3216[[[[620e[[[[231e,1*183":return
53804 t$="bcc$'290ylw1;2":return
53805 t$="bcs[(2bou1@6;2":return
53806 t$="beq[[2fod1p1;2":return
53807 t$="bit&-324$7$2322cj1$423":return
53808 t$="bmi[[230i1o1;2":return
53809 t$="bne*,2d08111;2":return
53810 t$="bpl[[210gl01;2":return
53811 t$="brk+.100[[[[01":return
53812 t$="bvc[/250f121;2":return
53813 t$="bvs[[270h1q1;2":return
53814 t$="clc)8118e3e601":return
53815 t$="cld[[1d8434501":return
53816 t$="cli13158:3:501":return
53817 t$="clv[[1b8[[[[01":return
53818 t$="cmp263c9[[[[12c547=132d5487262cd637323dd467483d9[[[[93c1616242d1[[[[52":return
53819 t$="cpx[[3eo+l(112e4n7n232ec[[[[23":return
53820 t$="cpy573co[[[[12c4[[[[32cc[[[[23":return
53821 t$="dec[[3c6[[[[32d6[[[[62ce[[[[23de[[[[83":return
53822 t$="dex4;1ca424401":return
53823 t$="dey[:188[[[[01":return
53824 t$="eor[[349[[[[1245:7c23255:8c3624d[[c4235d:6c58359[[[[9341l1[[4251[[[[52":return
53825 t$="inc9<3e652<132f6[[[[62ee[[[[23fe[[[[83":return
53826 t$="inx[=le8[[n101":return
53827 t$="iny[[1c8714101":return
53828 t$="jmp0m34cc1:4236ck1k4<3":return
53829 t$="jsr[[320[[[[23":return
53830 t$="lda?a3a9[[[[12a5a1v132b5b3a362adb4a423bd[[[[83b9@3b593al[[[[42bl[[[[52":return
53831 t$="ldx[[3a2@7b212a6[[[[32b631[[72ae[[[[23beb15193":return
53832 t$="ldy@d3a0&1'112a4[[[[32b4@8[[62ac[[[[23bcx1@583":return
53833 t$="lsr[[34a:1[[:146[[[[3256[[[[624e[[[[235e[[[[83":return
53834 t$="nopce1ea;1n401":return
53835 t$="ora[[309[[%11205e7%23215e8%3620de1%4231d[[[[8319[[e59301-1[[4211[[[[52":return
53836 t$="phabi148:2>101":return
53837 t$="php[[108e2e401":return
53838 t$="plag[168#2>201":return
53839 t$="plphk128)1)201":return
53840 t$="rol[[32a$1[[:126[[[[3236[[[[622e[[[[233e%5m183":return
53841 t$="rorjl36a#1[[:166[[[[3276[[[[626e#4[[237ej5a583":return
53842 t$="rti[[140[[[[01":return
53843 t$="rtsfs160.1/101":return
53844 t$="sbc[[3e9[[[[12e5[[[[32f5n8;262ed53;323fdn6;483f9[[[[93e1[[[[42f1[[[[52":return
53845 t$="secn[138$3$601":return
53846 t$="sedor1f8n3n501":return
53847 t$="sei[[178#3#601":return
53848 t$="staq[385t1s13295t2s2628dt3s3239d[[[[8399[[[[9381[[[[4291[[[[52":return
53849 t$="stxpw38691[[3296[[[[728e[[[[23":return
53850 t$="sty[[384r6[[3294r7[[628c[[[[23":return
53851 t$="taxtv1aa@2@401":return
53852 t$="tay[y1a8a2@101":return
53853 t$="tyau[198r2z101":return
53854 t$="tsx[[1ba[[[[01":return
53855 t$="txaxz18ar1r301":return
53856 t$="txs[[19ar5r401":return

54000 rem************* pseudo-operation operand
54010 gosub 55200
54015 if ps$="t" then b$=b$+chr$(0)
54020 if ps$="s" then pc=b : pm=pc; : po=1
54030 if ps$="e" then goto 54350
54040 if ps$="k" then pc=pc+b : for t=1 to b : c0=0 : gosub 60100 : next t
54050 if ps$="b" and b<256 then c0=b : gosub 60100 : pc=pc+l
54060 if ps$="b" and b>=256 then gosub 55400
54070 if ps$="d" then gosub 57620 : c0=b2 : gosub 60100 : c0=b1 : gosub 60100 : pc=pc+2
54080 if ps$="w" then gosub 57620 : gosub 57060
54090 if ps$="t" then fort=2tolen(b$)-1:c0=asc(mid$(b$,t,1)):gosub60100:pc=pc+1:next t
54100 if ps$="v" then l(vq)=b
54340 t0$="i" : return
54350 b$=la$ : gosub 54500
54360 if f$="d" then gosub 54580 : goto 54340
54370 l(l-1)=b : goto 54340

54500 rem************* label found & entered
54510 for t=0 to l
54520 if l$(t)<>b$ then next
54540 if t<>l+1 then f$="d" : vq=l : return
54550 l$(l)=b$ : l(l)=pc : vq=l : l=l+1 : la$=""
54560 return

54580 f=f+1 : f$(f)=zn$+" "+b$+" doubly defined." : print f$(f) : return

54800 rem************* label to mnemonic search variable address
54805 y=len(b$)
54810 if b$="accu" then op%=1 : ce%=10 : by=1 : gosub 57000 : return
54820 if left$(b$,1)="#" then 58000
54830 if left$(b$,1)="(" and right$(b$,3)=",x)" then 58400
54840 if left$(b$,1)="(" and right$(b$,1)=")" then 58200
54850 if left$(b$,1)="(" and right$(b$,3)="),y" then 58600
54860 if right$(b$,2)=",x" then 58800
54870 if right$(b$,2)=",y" then 59000
54880 goto 59200

55200 rem************* operand b$ - b dez
55205 if left$(b$,1)=chr$(34) then b=0 : return
55210 if left$(b$,1)="$" then gosub 57800 : return
55220 if asc(left$(b$,1))>47 and asc(left$(b$,1))<58 then gosub 57900 : return
55230 for t=0 to l : if l$(t)<>b$ then next
55240 if t=l+1 then gosub 62400
55245 if t=l+1 then print chr$(13);b$;" not yet defined."
55250 if t=l+1and(ce%=1orce%=4orce%=5)thenb=255:s$(s)=b$:s(s)=pc:s=s+1:return
55254 rem print"55254 b=256*256"
55255 if t=l+1 then b=256*256-1 : s$(s)=b$ : s(s)=pc : s=s+1 : return
55257 if k7=1 then k7=0 return
55260 b=l(t) : return

55300 rem************* hex to dec b$-b
55310 he$=mid$(b$,2,len(b$) - 1)
55320 gosub 59700
55330 b=de : return

55400 rem************* no operand possible - error
55410 f=f+1
55420 f$(f)=zn$+" "+b$+" not possible as operand." : printf$(f)
55430 return

55500 rem************* one-byte command
55510 me$=b$ : op%=1 : ce%=0
55520 gosub 55600
55530 c0=co : gosub 60100
55540 pc=pc+1
55550 t0$="i" : mn$="j"
55560 return

55600 rem************* establish machine code co
55610 t1=len(t$)-6
55620 for t=0 to t1/8-1
55630 if ce%=asc(mid$(t$,13+t*8,1))-48 then 55685
55640 next t
55660 f=f+1
55670 f$(f)=zn$+" addressing not allowed." : printf$(f)
55680 c0=234 : return

55685 if op%<>val(mid$(t$,14+t*8,1)) then 55660
55690 he$=mid$(t$,7+t*8,2) : gosub 59700
55695 co=de : return

55700 rem************* command with relative addressing
55710 me$=b$ : op%=2 : ce%=11
55720 gosub 55600
55730 c0=co : gosub 60100
55740 pc=pc+1
55750 t0$="r" : mn$="j"
55760 return

56000 rem************* command with variable addressing
56010 me$=b$ : t0$="m" : mn$="j" : return

56500 rem************* operand with relative address
56510 if left$(b$,1)<>"$" then goto 56600
56520 gosub 57800 : gosub 55300
56530 if b>255 then 55670
56540 c0=b : gosub 60100
56550 pc=pc+1
56560 t0$="i"
56570 return

56600 if asc(left$(b$,1))>47 and asc(left$(b$,1))<58 then gosub 57900 : goto 56530

56610 for t=0 to l : if l$(t)<>b$ then next
56620 if t=l+l then n$(n)=b$ : n(n)=pc: n=n+l : b=255 : goto 56530
56630 b=255-pc+l(t) : goto 56530

57000 rem************* search for co & poke
57010 if f$="j" then t0$= "i" : return
57020 gosub 55600
57030 c0=co : gosub 60100 : pc=pc+1
57040 if by=1 then t0$= " i " : return
57050 if by=2 then c0=b1 : gosub 60100 : pc=pc+1 : t0$="i" : return
57060 c0=b1 : gosub 60100 : c0=b2 : gosub 60100 : pc=pc+2 : t0$="i" : return

57590 rem************* test operand and set b1/b2
57600 if b<0 then 57650
57610 if b<256 then by=2 : b1=b : b2=0 : return
57620 if b>65536 then 57650
57630 by=3 : b2=int(b/256) : b1=b-b2*256 : return
57650 f=f+1 : f$(f)=zn$+" "+str$(b)+" not legal ." : printf$(f) : f$="j" : return

57700 rem************* test if hex number
57800 for t=2 to len(b$) : te=asc(mid$(b$,t,1))
57810 if te>47 and te<58 or te>64 and te<71 then next : gosub 55300 : return
57830 f=f+1 : f$(f)=zn$ +" " +b$+" not a hex number ." : printf$(f) : f$="j"
57840 b=0 : return

57890 rem************* test if decimal number
57900 for t=1 to len(b$) - 1 : te=asc(mid$(b$,t,1))
57910 if te>47 and te<58 then next : b=val(b$) : return
57930 f=f+1 : f$(f)=zn$+" " +b$ +" not a decimal number ." : printf$(f) : f$="j"
57950 b=0 : return

57980 rem************* separating operands by mnemonic
58000 b$=mid$(b$,2,y-1) : ce%=1 : gosub 59400 : op%=by : goto 57000
58200 b$=mid$(b$,2,y-2) : gosub 59400 : op%=3 : ce%=12 : goto 57000
58400 b$=mid$(b$,2,y-4) : ce%=4 : gosub 59400 : op%=by : goto 57000
58600 b$=mid$(b$,2,y-4) : ce%=5 : gosub 59400 : op%=by : goto 57000
58800 b$=mid$(b$,1,y-2) : gosub 59400 : op%=by : ce%=6
58810 if by=3 then ce%=8
58820 goto 57000
59000 b$=mid$(b$,1,y-2) : ce%=7 : gosub 59400 : op%=by
59010 if by=3 then ce%=9
59020 goto 57000
59200 b$=mid$(b$,1,y) : ce%=3 : gosub 59400 : op%=by
59210 if by=3 then ce%=2
59220 goto 57000

59300 rem************* b$ to b
59400 gosub 55200 : goto 57600

59700 rem************* convert hex to dec
59710 de=0
59720 for t=len(he$) to 1 step -1
59730 h2$=mid$(he$,t,1)
59740 for t1=1 to 16
59750 if mid$("0123456789abcdef",t1,1)<>h2$ then next t1
59760 de=de+(t1-1)*16^(len(he$)-t)
59770 next t : return

60000 rem************* open the output file
60010 print#15,"s:"+na$+"zw"
60020 input#15,en,em$,et,es : rem print "    **";left$(em$,13);"**"
60030 open 9,8,9,"0:"+na$+"zw"+",p,w" : gosub 50800 : if en<>0 then stop
60035 print#9,chr$(0)chr$(0);
60040 return

60100 rem************* output to disk
60110 co%=co%+1
60120 if co%<254 then bl$=bl$+chr$(c0) : return
60130 print#9,bl$;
60135 rem print "bl$ = "";bl$
60140 bl$=chr$(c0) : co%=1
60150 return

60200 rem************* assign the last block
60205 rem print"bl$ =";bl$,len(bl$)
60210 print#9,bl$; : return

61000 rem ************ pass ii
61005 if st <>64 then 50800
61010 gosub 60200
61020 close 9 : gosub 50800 : if en<>0 then 48000
61022 rem open 9,8,9,na$+11 zw,p,r11
61024 rem get#9,b$ : if st<>0 then close 9 : goto 61030
61026 rem if b$="" then print0; : goto 61024
61028 rem print asc(b$); : goto 61024
61030 rem print asc(b$) : close 9 : gosub 50800 : if en<>0 then stop
61040 print#15,"s:"+na$+"-obj"
61050 input#15,en,em$,et,es : rem print "    ** "; left$(em$,13);"**"
61060 open9,8,9,"0:"+na$+"-obj"+",p,w" : gosub 50800 : if en<>0 then goto 48000
61062 p7=pc : pc=pm : t2=int(pm/256) : t3=pm-t2*256
61063 if po=1 then print#9, chr$(t3)chr$(t2);
61064 if po=0 then print#9, chr$(1 )chr$(8 );
61065 gosub 62100
61066 rem print" st="; st
61070 open 8,8,8,"0:"+na$+"zw" +",p,r"
61072 get#8,b$
61073 get#8,b$
61090 s(s)=65000 : n(n)=65000 : t2=0 : t3=0
61100 if s(t2)=65000 and n(t3)=65000 then 61600
61110 if s(t2)=65000 then t4=n(t3) : t5$=n$(t3) : t3=t3+1 : t6$="r" : goto61150
61120 if n(t3)=65000 then t4=s(t2)+1 : t5$=s$(t2) : t2=t2+1 : t6$="a": goto61150
61140 if s(t2)<n(t3) then t4=s(t2)+1 : t5$=s$(t2) : t2=t2+1 : t6$="a" : goto 61150
61145 t4=n(t3) : t5$=n$(t3) : t3=t3+1 : t6$="r"
61150 for t=0 to l
61160 if l$(t)<>t5$ then next t
61170 if t=l+1 then f=f+1 : f$(f)=b$+" not defined . " : goto 61100
61180 if t6$="r" then 61500
61190 b=l(t) : gosub 57630
61200 get#8,g$ : if g$="" then g$=chr$(0)
61205 if pc<>t4 then print#9,g$; : pc=pc+1 : goto 61200
61210 get#8,h$ : if h$="" then h$=chr$(0)
61220 ifasc(g$)=255andasc(h$)=255thenprint#9,chr$(b1)chr$(b2);:pc=pc+2:goto61100
61230 ifasc(g$)=255andb<256thenprint#9,chr$(b);h$;: pc=pc+2 : goto61100
61240 f=f+1 : f$(f)="label "+str$(pc)+" illegal or declared earlier."
61250 goto 61100
61500 b=l(t) - n(t3-1)-1
61510 if pc<>t4 then get#8,g$ : if g$="" then g$=chr$(0)
61515 if pc<>t4 then print#9,g$; : pc=pc+1 : goto 61510
61520 if b>127 then f=f+1 : f$(f)="no relative jump " +str$(pc)+" possible."
61530 if b>127 then pc=pc+1 : goto 61100
61540 print#9,chr$(b); : pc=pc+1 : get#8,g$ : goto 61100
61600 get#8,g$ : if g$="" then g$=chr$(0)
61601 if st=0 then print#9,g$; : goto 61600
61603 print#9,g$;
61605 print#9,chr$(0)chr$(0)chr$(0);
61610 close 9 : gosub 50800 : if en<>0 then 48000
61620 close 8 : gosub 50800 : if en<>0 then 48000
61630 print#15,"s:"+na$+"zw"
61640 input#15,en,em$,et,es : rem print em$
61645 close

62100 rem **** missing lines!
62110 print "function at 62100 not defined"
62120 return

62300 rem **** missing lines! assuming end of prg
62310 close 8 : close 9 : close 15
62320 end

62400 rem **** missing lines!
62410 print "function at 62400 not defined"
62420 return
