1000 program selection is
1010 --
1020 --
1030 -- "This program outputs a sentence
1040 -- to the screen or printer
1050 -- depending on user input.
1060 --
1070 --
1080 float test, one.
1090 --
1100 begin
1120 clearscreen. linefeed.
1130 --
1140 write "Output to printer (1) or screen (2) ?".
1150 get test.
1160 linefeed.
1170 assign 1.0 tovar one.
1180 --
1190 if test = one then
1200 --
1210 outputdevice printer.
1220 writeln "Output to the printer.".
1230 outputdevice screen.
1240 --
1250 else
1260 --
1270 writeln "Output to the screen.".
1280 --
1290 endif.
1300 --
1310 pend selection.
