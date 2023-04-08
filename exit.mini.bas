100 program exyt is
110 --
120 --
130 -- "This program tests
140 -- the exit-loop
150 -- instruction.
160 --
170 --
180 float sam, george, one.
190 --
200 begin
210 --
220 assign 1.0 tovar one.
230 assign 0.0 tovar george.
240 assign 100.0 tovar sam.
250 --
260 --
270 loop outer over
280 --
290 --
300 loop inner over
310 --
320 --
330 writeln george.
340 --
350 exit outer if george = sam.
360 --
370 add one and george tovar george.
380 --
390 --
400 lend inner.
410 --
420 lend outer.
430 --
440 pend exyt.
