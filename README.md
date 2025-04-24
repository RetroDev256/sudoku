# What?
It's a command-line sudoku solver that is made to be ultra tiny. Of course, the page size of many file systems makes a size below 4k no different than any other, but it's still fun to work with :)
The current size of the linux binary is 570 bytes.

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
| 54 00 01 00 b1 01 00 00 | b2 01 00 00 07 00 00 00 |T⋄•⋄×•⋄⋄|×•⋄⋄•⋄⋄⋄|
| 00 10 00 00 31 ed 89 e0 | 83 e4 f0 83 ec 0c 50 e8 |⋄•⋄⋄1×××|×××××_P×|
| 00 00 00 00 55 89 e5 53 | 57 56 83 ec 70 8b 55 08 |⋄⋄⋄⋄U××S|WV××p×U•|
| 8b 42 08 8a 08 84 c9 74 | 08 80 c1 d0 88 08 40 eb |×B•×•××t|•××××•@×|
| f2 8b 72 08 6a 51 59 8d | 7d 87 89 75 f0 f3 a4 31 |××r•jQY×|}××u×××1|
| f6 8b 55 f0 31 c0 83 f8 | 09 74 6a 31 c9 89 55 ec |××U×1×××|_tj1××U×|
| 89 45 d8 39 c1 74 5a 31 | db 89 4d e8 83 fb 09 74 |×E×9×tZ1|××M×××_t|
| 4d 8d 3c db 01 f8 89 45 | dc 01 cf 89 7d e0 89 5d |M×<×•××E|×•××}××]|
| e4 83 eb 01 72 29 8b 45 | f0 8b 4d dc 8a 04 08 84 |×××•r)×E|××M××••×|
| c0 74 17 8b 4d f0 8b 7d | e0 3a 04 39 0f 84 97 00 |×t•×M××}|×:•9•××⋄|
| 00 00 3a 02 0f 84 8f 00 | 00 00 83 c2 09 eb d2 8b |⋄⋄:••××⋄|⋄⋄××_×××|
| 5d e4 43 8b 55 ec 8b 45 | d8 8b 4d e8 eb ae 41 eb |]×C×U××E|××M×××A×|
| a2 40 42 eb 91 31 c0 8b | 4d f0 83 f8 03 74 7f 31 |×@B××1××|M×××•t•1|
| d2 89 cf 89 45 e8 89 4d | ec 83 fa 03 74 4c 89 55 |××××E××M|×××•tL×U|
| e0 31 c0 89 7d e4 31 db | 83 f8 03 74 2b 89 45 dc |×1××}×1×|××•t+×E×|
| 6a fd 5a 85 d2 74 18 0f | b6 4c 17 03 85 c9 74 0c |j×Z××t••|×L••××t_|
| 31 c0 40 d3 e0 0f a3 cb | 72 2f 09 c3 42 eb e4 8b |1×@××•××|r/_×B×××|
| 45 dc 40 83 c7 09 eb d0 | 8b 55 e0 42 8b 7d e4 83 |E×@××_××|×U×B×}××|
| c7 03 8b 45 e8 8b 4d ec | eb af 40 83 c1 1b eb 9a |×•×E××M×|××@××•××|
| 85 f6 0f 84 85 00 00 00 | 4e 80 7c 35 87 00 75 f0 |××•××⋄⋄⋄|N×|5×⋄u×|
| 8b 45 f0 fe 0c 30 0f 85 | 05 ff ff ff eb e2 8b 45 |×E××_0•×|•××××××E|
| f0 80 3c 30 00 74 15 83 | fe 50 74 1c 46 80 7c 35 |××<0⋄t•×|×Pt•F×|5|
| 87 00 74 08 46 83 fe 51 | 75 f3 eb 0c 8b 45 f0 c6 |×⋄t•F××Q|u××_×E××|
| 04 30 09 e9 d9 fe ff ff | 8b 45 08 8b 78 08 31 c0 |•0_×××××|×E•×x•1×|
| 31 db 43 83 f8 09 74 35 | 89 45 f0 6a f7 5e 85 f6 |1×C××_t5|×E×j×^××|
| 74 16 8a 44 37 09 0c 30 | 88 45 87 6a 04 58 8d 4d |t•×D7__0|×E×j•X×M|
| 87 89 da cd 80 46 eb e6 | 6a 04 58 b9 04 02 01 00 |×××××F××|j•X×•••⋄|
| 89 da cd 80 8b 45 f0 40 | 83 c7 09 eb c6 31 c0 40 |×××××E×@|××_××1×@|
| 31 db cd 80 0a          |                         |1×××_   |        |
+-------------------------+-------------------------+--------+--------+
```
