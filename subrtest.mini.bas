100 program subrtest is
110 --
120 --
130 -- "This program calls either
140 -- subroutine a or b.
150 --
160 --
170 float test, one.
180 --
190 begin
200 --
210 assign 1.0 tovar one.
220 --
230 jumplabel start.
240 --
250 writeln "Subroutine a(1) I b(2)".
260 --
270 get test. linefeed.
280 --
290 if test /= one then
300 --
310 call a.
320 --
330 else
340 --
350 call b.
360 --
370 endif.
380 --
390 jump start.
400 --
410 pend subrtest.
420 --
430 ----------------------
440 subroutine a is
450 --
460 writeln "Subroutine a .".
470 --
480 srend a.
490 --
500 ----------------------
510 subroutine b is
520 --
530 writeln "Subroutine b.".
540 --
550 srend b.
