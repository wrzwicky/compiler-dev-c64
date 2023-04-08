100 program hundred is
110 --
120 --
130 -- "This program outputs
140 -- all positive integers
150 -- up to one hundred.
160 --
170 --
180 float number, one, hundred.
190 --
200 begin
210 --
220 assign 1.0 tovar one.
230 --
240 assign 0.0 tovar number.
250 --
260 assign 100.0 tovar hundred.
270 --
280 loop int over
290 --
300 writeln number.
310 --
320 add one and number tovar number.
330 --
340 exit int if hundred = number.
350 --
360 lend int.
370 --
380 pend hundred.
