# What?
It's a command-line sudoku solver that is made to be ultra tiny. Of course, the page size of many file systems makes a size below 4k no different than any other, but it's still fun to work with :)
The current size of the linux binary is 489 bytes.

# Usage:
`sudoku GRID` - where `GRID` is a string of 81 consecutive digits, 0 representing empty cells.
eg. `./sudoku 530070000600195000098000060800060003400803001700020006060000280000419005000080079`

Compile with `zig build -Drelease -Drisky shrink`
(Will require sstrip from elfkickers)

The program will not output anything if the input grid cannot be solved. It is undefined behavior if you don't give it a valid input grid.

# Hexdump:
```
+-------------------------+-------------------------+--------+--------+
| 7f 45 4c 46 01 01 01 00 | 00 00 00 00 00 00 00 00 |•ELF•••⋄|⋄⋄⋄⋄⋄⋄⋄⋄|
| 02 00 03 00 01 00 00 00 | 54 00 01 00 34 00 00 00 |•⋄•⋄•⋄⋄⋄|T⋄•⋄4⋄⋄⋄|
| 00 00 00 00 00 00 00 00 | 34 00 20 00 01 00 28 00 |⋄⋄⋄⋄⋄⋄⋄⋄|4⋄ ⋄•⋄(⋄|
| 00 00 00 00 01 00 00 00 | 54 00 00 00 54 00 01 00 |⋄⋄⋄⋄•⋄⋄⋄|T⋄⋄⋄T⋄•⋄|
| 54 00 01 00 95 01 00 00 | 95 01 00 00 07 00 00 00 |T⋄•⋄×•⋄⋄|×•⋄⋄•⋄⋄⋄|
| 00 10 00 00 89 e0 50 e8 | 00 00 00 00 55 89 e5 53 |⋄•⋄⋄××P×|⋄⋄⋄⋄U××S|
| 57 56 83 ec 70 8b 45 08 | 8b 40 08 89 45 f0 8a 08 |WV××p×E•|×@•×E××•|
| 84 c9 74 08 80 c1 d0 88 | 08 40 eb f2 6a 51 59 8d |××t•××××|•@××jQY×|
| 7d 87 8b 75 f0 f3 a4 31 | c0 8b 4d f0 31 d2 83 fa |}××u×××1|××M×1×××|
| 03 74 65 31 f6 89 cf 89 | 4d e0 89 55 e4 83 fe 03 |•te1××××|M××U×××•|
| 74 50 89 75 dc 31 c9 89 | 7d e8 31 d2 83 f9 03 74 |tP×u×1××|}×1×××•t|
| 2f 89 4d ec 6a fd 5e 85 | f6 74 1c 0f b6 4c 37 03 |/×M×j×^×|×t••×L7•|
| 85 c9 74 10 31 db 43 d3 | e3 0f a3 ca 0f 82 9d 00 |××t•1×C×|×•××•××⋄|
| 00 00 09 da 46 eb e0 8b | 4d ec 41 83 c7 09 eb cc |⋄⋄_×F×××|M×A××_××|
| 8b 75 dc 46 8b 7d e8 83 | c7 03 8b 4d e0 8b 55 e4 |×u×F×}××|×•×M××U×|
| eb ab 42 83 c1 1b eb 96 | 31 c9 8b 55 f0 89 55 e8 |××B××•××|1××U××U×|
| 83 f9 09 0f 84 81 00 00 | 00 31 d2 89 4d d8 39 ca |××_•××⋄⋄|⋄1××M×9×|
| 74 52 31 db 89 55 e4 83 | fb 09 74 45 8d 34 db 01 |tR1××U××|×_tE×4×•|
| f1 89 4d ec 01 d6 89 75 | dc 89 5d e0 8b 4d e8 83 |××M×•××u|××]××M××|
| eb 01 72 21 8b 55 f0 8b | 75 ec 8a 14 32 84 d2 74 |×•r!×U××|u××•2××t|
| 0f 8b 75 f0 8b 7d dc 3a | 14 3e 74 23 3a 11 74 1f |•×u××}×:|•>t#:•t•|
| 83 c1 09 eb da 8b 5d e0 | 43 8b 4d d8 8b 55 e4 eb |××_×××]×|C×M××U××|
| b6 42 eb aa 41 ff 45 e8 | eb 96 85 c0 74 74 48 80 |×B××A×E×|××××ttH×|
| 7c 05 87 00 75 f4 8b 4d | f0 fe 0c 01 0f 85 07 ff ||•×⋄u××M|××_••×•×|
| ff ff eb e6 83 f8 50 74 | 16 40 8b 4d f0 80 3c 01 |××××××Pt|•@×M××<•|
| 00 75 f1 8b 4d f0 c6 04 | 01 09 e9 ea fe ff ff 31 |⋄u××M××•|•_×××××1|
| c0 6a 04 5e 8d 4d 87 31 | db 43 83 f8 09 74 33 89 |×j•^×M×1|×C××_t3×|
| 45 ec 6a f7 5f 85 ff 74 | 15 8b 45 f0 8a 44 38 09 |E×j×_××t|•×E××D8_|
| 0c 30 88 45 87 89 f0 89 | da cd 80 47 eb e7 c6 45 |_0×E××××|×××G×××E|
| 87 0a 89 f0 89 da cd 80 | 8b 45 ec 40 83 45 f0 09 |×_××××××|×E×@×E×_|
| eb c8 31 c0 40 31 db cd | 80                      |××1×@1××|×       |
+-------------------------+-------------------------+--------+--------+
```
