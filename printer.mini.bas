1000 program printer is
1010 --
1020 --
1030 -- This program writes the sentence
1040 -- "Now the printer prints!" on the printer
1050 -- and outputs the sentence "now back
1060 -- to the screen" on the screen.
1070 --
1080 --
1090 begin
1100 --
1110 outputdevice printer.
1120 --
1130 writeln "Now the printer prints!".
1140 --
1150 outputdevice screen.
1160 --
1170 --
1180 writeln "now back to the screen".
1190 --
1200 --
1210 pend printer.
