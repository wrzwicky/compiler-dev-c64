100 program infinite is
130 -- "This program outputs all
140 -- positive integers in the
150 -- calculation range.
180 float number, one.
190 --
200 begin
210 --
220 assign 1.0 tovar one.
230 --
240 assign 0.0 tovar number.
250 --
260 loop int over
270 --
280 writeln number.
290 --
300 add one and number tovar number.
310 --
320 lend int.
330 --
340 pend infinite.
