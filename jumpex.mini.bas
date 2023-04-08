100 program jumpex is
110 --
120 --
130 -- "This program is ended
140 -- when 1 is entered.
150 --
160 --
170 float one, test.
180 --
190 begin
200 --
210 assign 1.0 tovar one.
220 --
230 jumplabel start.
240 --
250 get test. linefeed.
260 --
270 if test = one then
280 --
290 empty.
300 --
310 else
320 --
330 jump start.
340 --
350 endif.
360 --
370 pend jumpex.
