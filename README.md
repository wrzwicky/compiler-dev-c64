Finished programs from the book
"Compiler Design and Implementation for C-64 & C-128"
by Volker Sasse,
published by Abacus Software.

1. Parser works
2. Show Parse works
3. Analysis works
4. Assembler is incomplete and crashes.
5. Compressor strange and undocumented, and doesn't work.

Errors:
* assembler: missing lines in source code
* parser: 
  - syntax errors may cause 'bad subscript error in 10440'
* conditional.mini: not allowed in program name
* exit.mini: can't name a program with a keyword
* printer.mini: triggers a bug in Analysis "semantic error token=15"
* selection.mini: same bug
