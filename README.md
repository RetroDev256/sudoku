# What?
It's a command-line sudoku solver that is made to be ultra tiny. Of course, the page size of many file systems makes a size below 4k no different than any other, but it's still fun to work with :)
The current size of the linux binary is 466 bytes.

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
| 54 00 01 00 7e 01 00 00 | 7e 01 00 00 07 00 00 00 |T⋄•⋄~•⋄⋄|~•⋄⋄•⋄⋄⋄|
| 00 10 00 00 89 e0 50 e8 | 00 00 00 00 55 89 e5 53 |⋄•⋄⋄××P×|⋄⋄⋄⋄U××S|
| 57 56 83 ec 74 8b 45 08 | 8b 50 08 31 c0 8a 0c 02 |WV××t×E•|×P•1××_•|
| 84 c9 74 0d 80 c1 d0 88 | 0c 02 88 4c 05 83 40 eb |××t_××××|_•×L•×@×|
| ec 31 c0 89 55 e8 89 d1 | 31 f6 83 fe 03 74 67 31 |×1××U×××|1×××•tg1|
| ff 89 4d ec 89 4d e0 89 | 75 e4 83 ff 03 74 51 31 |××M××M××|u×××•tQ1|
| c9 8b 55 ec 31 f6 89 7d | dc 83 f9 03 74 32 89 4d |××U×1××}|×××•t2×M|
| d8 6a fd 5b 85 db 74 1c | 0f b6 4c 1a 03 85 c9 74 |×j×[××t•|•×L••××t|
| 10 31 ff 47 d3 e7 0f a3 | ce 0f 82 96 00 00 00 09 |•1×G××•×|×•××⋄⋄⋄_|
| fe 43 eb e0 8b 4d d8 41 | 83 c2 09 8b 7d dc eb c9 |×C×××M×A|××_×}×××|
| 47 83 45 ec 03 8b 55 e8 | 8b 4d e0 8b 75 e4 eb aa |G×E×•×U×|×M××u×××|
| 46 83 c1 1b eb 94 31 c9 | 89 55 ec 83 f9 09 0f 84 |F××•××1×|×U×××_•×|
| 81 00 00 00 31 f6 89 4d | d4 39 ce 74 52 31 ff 89 |×⋄⋄⋄1××M|×9×tR1××|
| 75 e4 83 ff 09 74 45 8d | 1c ff 01 d9 89 4d d8 01 |u×××_tE×|•×•××M×•|
| f3 89 5d dc 89 7d e0 8b | 4d ec 83 ef 01 72 21 8b |××]××}××|M×××•r!×|
| 75 d8 8a 14 32 84 d2 74 | 0f 8b 75 e8 8b 5d dc 3a |u××•2××t|•×u××]×:|
| 14 1e 74 21 3a 11 74 1d | 83 c1 09 8b 55 e8 eb da |••t!:•t•|××_×U×××|
| 8b 7d e0 47 8b 4d d4 8b | 75 e4 eb b6 46 eb aa 41 |×}×G×M××|u×××F××A|
| ff 45 ec eb 96 8b 55 e8 | 80 7c 05 83 00 75 09 fe |×E××××U×|×|•×⋄u_×|
| 0c 02 0f 85 0e ff ff ff | 85 c0 74 4f 48 eb e9 83 |_••×•×××|××tOH×××|
| f8 50 74 10 40 80 3c 02 | 00 75 f4 c6 04 02 09 e9 |×Pt•@×<•|⋄u××••_×|
| f2 fe ff ff 6a 09 5f 6a | af 5e 8d 4d f3 31 db 43 |××××j__j|×^×M×1×C|
| 85 f6 74 27 8a 44 32 51 | 04 30 88 45 f3 6a 04 58 |××t'×D2Q|•0×E×j•X|
| 89 da cd 80 4f 75 0e c6 | 45 f3 0a 6a 04 58 89 da |××××Ou•×|E×_j•X××|
| cd 80 6a 09 5f 46 8b 55 | e8 eb d5 31 c0 40 31 db |××j__F×U|×××1×@1×|
| cd 80                   |                         |××      |        |
+-------------------------+-------------------------+--------+--------+
```
