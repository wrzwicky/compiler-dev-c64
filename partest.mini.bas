1000 program partest is
1020 --
1030 -- "This program tests the nested
1040 -- loops with parameters.
1050 -- "The result should be 1000.
1070 --
1080 float indexa, indexb, indexc.
1090 float lowerbound, upperbound, number, one.
1100 --
1110 begin
1120 --
1130 assign 1.0 tovar lowerbound.
1140 assign 10.0 tovar upperbound.
1150 assign 0.0 tovar number.
1155 assign 1.0 tovar one.
1160 --
1170 --
1180 for indexa from lowerbound to upperbound repeat
1190 --
1200 for indexb from lowerbound to upperbound repeat
1210 --
1220 for indexc from lowerbound to upperbound repeat
1230 --
1240 add one and number tovar number.
1250 --
1260 lend.
1270 lend.
1280 lend.
1290 --
1300 writeln "The result is:". writeln number.
1310 --
1320 pend partest.
