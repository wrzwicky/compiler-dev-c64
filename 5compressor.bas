!- 8.1 BASIC COMPRESSOR LISTING

53000 rem =============================
53010 rem basic - compressor
53030 rem by volker sasse
53050 rem for list20 & cbm64
53070 rem basic version, 2.0
53080 rem =============================

54010 print"{clear}{down*3}    basic - compressor"
54020 print"{down*3}    maximum line length "
54021 input"      60{left}{left}{left}{left}";zm
54022 print"{down}    first line number "
54023 input"      10{left}{left}{left}{left}";sa
54024 print"{down}    line number increment"
54025 input"      10{left}{left}{left}{left}";ab
54027 print"{down}    number of lines"
54028 input"      300{left}{left}{left}{left}{left}";a9

54030 dim a(a9),m%(a9),vs(a9)
54040 l=4608
54045 if peek(64787)=56 and peek(64788)=48 then l=2048
54050 h=peek(44)*256+peek(43) : z=l-1 : n1=l
54055 print"{down}{left}{left}pass 1        line  : “;
54060 z=z+1 : if z>h then 54175
54070 t=peek(z)
54080 if t=34 then gosub 57500
54090 if t=32 then poke z,7 : goto 54060
54100 if t=139 then gosub 57300 : goto 54060
54110 if t=167 then gosub 56200 : goto 54060
54120 if t=137 then gosub 56400 : goto 54060
54130 if t=141 then gosub 56400 : goto 54060
54140 if t=0 then z=z+3 : gosub 57700 : goto 54060
54150 if t=58 then gosub 57650 : goto 54060
54160 if t=143 then gosub 57600 : goto 54060
54170 goto 54060
54175 rem ============= pass 1 end
54176 m%(1)=1
54177 gosub 57100
54178 rem ============= pass 2 end
54180 for t=1 to vo : zn=vs(t) : gosub 57000 : next
54200 t1=1
54210 for t=1 to zl
54220 if m%(t)=1 then a(t1)=a(t) : t1=t1+1
54230 next
54235 for t=t1 to zl : a(t)=0 : next
54240 zl=t1-1
54300 z=l-1 : pz=l-1 : z4=1
54305 print : print"{down}{left}{left}pass 3        line  : “;
54310 z=z+1 : if z>h then 54400
54320 t=peek(z)
54340 if t=7 then 54310
54345 if t=34 then gosub 58000 : if t=34 then 54310
54350 if t=167 then pz=pz+1:poke pz,167 : gosub56100:goto54310
54360 if t=137 then pz=pz+1:poke pz,137 : gosub55800 :goto54310
54370 if t=141 then pz=pz+1:poke pz,141:gosub55800:goto54310
54380 if t=0 then gosub 56600 : goto 54310
54390 pz=pz+1 : poke pz,t : goto 54310
54400 pz=pz-1:poke pz-2,0:poke pz-1,0
54410 h=int (pz/256) : i=pz-int (pz/256) *256
54412 poke 828,i : poke 829,h
54413 rem ============= pass 3 end
54414 poke l,0
54415 print:print"{down}    ";z-pz;"bytes less!"
54420 poke 43,1 : poke 44,18 : if l=2048 then poke 44,8
54430 poke 45,peek(828) : poke46,peek(829) : clr : end
55398 :
55400 rem ============ additional line numbers
55401 :
55410 z=z+1 : t=peek(z)
55420 if t=7 then 55410
55430 if t=44 then pz=pz+1 : poke pz,44 : goto 55410
55440 if t>47 and t<58 then gosub 55600 : goto 55400
55450 z=z-1 : return
55598 :
55600 rem ============ recognize and replace line numbers
55602 :
55610 z=z-1 : zn$=""
55620 z=z+1
55622 if peek(z)>47andpeek(z)<58thengosub55700 : goto55620
55630 zn=val(zn$) : z=z-1
55640 for t1=1 to zl : if a(t1)<zn then next
55650 rem ============ t1 new line number
55660 zn$=str$((t1-1)*ab+sa)
55670 for t1=2 to len(zn$)
55672 pz=pz+1 :poke pz,asc(mid$(zn$,t1,1))
55674 next
55680 return
55681 :
55700 zn$=zn$+chr$(peek(z)) : return
55702 :
55800 rem ============ line numbers after goto / gosub
55802 :
55810 z=z+1 : t=peek(z)
55820 if t=7 then 55810
55830 if t>47andt<58thengosub55600:gosub55400:return
55840 z=z-1 : return
55841 :
56000 rem ============ save line number then/goto/gosub
56001 :
56010 z=z-1 : zn$=""
56020 z=z+1
56022 if peek(z)>47andpeek(z)<58thengosub55700 : goto56020
56030 zn=val (zn$)
56040 if zn<=a(zl) then gosub 57000 : goto 56055
56050 vo=v0+1 : vs(vo)=zn
56055 z=z-1
56060 return
56061 :
56100 rem ============ line number after then
56102 :
56110 z=z+1 : t=peek(z)
56120 if t=7 then 56110
56130 if t=137 then pz=pz+1:poke pz,137:gosub55800:return
56140 if t=141 then pz=pz+1:poke pz,141:gosub55800:return
56150 if t>47 and t<58 then gosub 55600 : return
56160 z=z-1 : return
56161 :
56200 rem ============ line number after then
56202 :
56210 z=z+1 : t=peek(z)
56220 if t=32 then poke z,7 : goto 56210
56230 if t=137 then gosub 56400 : return
56235 if t=141 then gosub 56400 : return
56240 if t>47 and t<58 then gosub 56000 : return
56250 z=z-1 : return
56252 :
56400 rem ============ line number after goto / gosub
56402 :
56410 z=z+1 : t=peek(z)
56420 if t=32 then poke z,7 : goto 56410
56430 if t>47andt<58thengosub56000:gosub56800:return
56440 z=z-1 : return
56599 :
56600 rem ============ can line be resolved?
56610 rem ============ change the line number
56620 zn=peek(z+3)+peek(z+4)*256
56622 print spc(8-len(str$(zn)))str$(zn);
56625 if z=h-1 then 56650
56630 if a(z4)=zn then 56650
56640 pz=pz+1 : poke pz,58 : z=z+4 : return
56650 pz=pz+1 : poke pz,0
56655 poke n1,pz+1-int((pz+1)/256)*256
56657 poke n1+1,int((pz+1)/256)
56660 n1=pz+1 : z5=(z4-1)*ab+sa
56665 poke pz+3,z5-int(z5/256)*256 : poke pz+4,int(z5/256)
56670 pz=pz+4 : z4=z4+1 : z=z+4 : return
56671 :
56800 rem ============ additional line numbers
56802 :
56810 z=z+1 : t=peek(z)
56820 if t=32 then poke z,7 : goto 56810
56830 if t=44 then 56810
56840 if t>47 and t<58 then gosub56000:gosub57300:goto56800
56850 z=z-1 : return
56852 :
57000rem ============ search for zn in a() and save in m% ()
57001 :
57010 for z4=1 to zl
57020 m%(z4)=1 : if a(z4)<zn then next
57030 return
57032 :
57100 rem ============ set line length
57102 :
57105 print : print"{down}{left}{left}pass 2        line  : “;
57110 z=l-1 : t=0
57120 z=z+1 : q=peek(z)
57130 if q=0 then 57160
57140 if q<>7 then zc=zc+1
57150 goto 57120
57160 t=t+1 : if zz+zc>zm then m%(t-1)=1 : zz=zc : zc=0
57163 zn=peek(z+3)+peek(z+4)*256
57165 print spc(8-len(str$(zn)))str$(zn);
57170 if m%(t)=1 then zz=0 : zc=0 : goto 57200
57180 zz=zz+zc
57190 zc=0
57200 if z=h-1 then return
57201 z=z+4 : goto 57120
57202 :
57300 rem ============ save next line for if/on
57302 :
57310 m%(zl+1)=1 : return
57312 :
57500 rem ============ skip strings
57520 :
57530 z=z+1 : t=peek(z) : if t<>34 and t<>0 then 57530
57540 return
57560 :
57600 rem ============ delete comment lines
57602 :
57605 if peek(z-1)=58 then poke z-1,7 :poke z,7 : goto 57620
57606 if peek(z-1)=7 and peek(z-2)=58 then poke z-2,7 :poke z,7: goto 57620
57610 zl=zl-1 : for z3=z-5 to z : poke z3,7 : next
57620 z=z+1 : if peek(z)<>0 then poke z,7 : goto 57620
57630 z=z+3 : gosub 57700 : return
57632 :
57650 rem ============ delete colon lines
57652 :
57655 if peek(z-5)=0 and peek(z+1)=0 then 57660
57657 return
57660 zl=zl-1 : for z3=z-5 to z : poke z3,7 : next
57670 z=z+4 : gosub 57700 : return
57671 :
57700 rem ============ save line numbers
57720 :
57730 zl=zl+1 : a(zl)=peek(z)+peek(z+1)*256
57735 print spc(8-len(str$(a(zl))))str$(a(zl));
57740 z=z+l : return
58000 rem=========== pass strings
58010 pz=pz+1 : poke pz,34
58020 z=z+1 : t=peek(z)
58030 if t=0 or t=34 then pz=pz+1 : poke pz,34 : return
58040 pz=pz+1 : poke pz,t : goto 58020
