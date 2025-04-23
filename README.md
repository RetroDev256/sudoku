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
| 54 00 01 00 e6 01 00 00 | e7 01 00 00 07 00 00 00 |T⋄•⋄×•⋄⋄|×•⋄⋄•⋄⋄⋄|
| 00 10 00 00 31 ed 89 e0 | 83 e4 f0 83 ec 0c 50 e8 |⋄•⋄⋄1×××|×××××_P×|
| 00 00 00 00 55 89 e5 53 | 57 56 81 ec cc 00 00 00 |⋄⋄⋄⋄U××S|WV×××⋄⋄⋄|
| 8b 45 08 8b 48 08 8a 11 | 84 d2 74 08 80 c2 d0 88 |×E•×H•×•|××t•××××|
| 11 41 eb f2 8b 70 08 6a | 51 59 8d 7d 87 89 75 ec |•A×××p•j|QY×}××u×|
| f3 a4 31 ff 8d 75 87 31 | c0 83 f8 09 74 2e 89 45 |××1××u×1|×××_t.×E|
| f0 83 65 e8 00 6a f7 5b | 85 db 74 17 0f b6 4c 1e |××e×⋄j×[|××t••×L•|
| 09 8d 55 e8 e8 57 01 00 | 00 43 a8 01 74 ea e9 b2 |_×U××W•⋄|⋄C×•t×××|
| 00 00 00 8b 45 f0 40 83 | c6 09 eb cd 31 db 8d 45 |⋄⋄⋄×E×@×|×_××1××E|
| 87 89 45 f0 83 fb 09 74 | 2c 83 65 e8 00 6a a6 58 |××E×××_t|,×e×⋄j×X|
| 89 c6 83 c6 09 74 18 8b | 4d f0 0f b6 4c 01 5a 8d |××××_t•×|M×•×L•Z×|
| 55 e8 e8 19 01 00 00 a8 | 01 89 f0 75 78 eb e3 43 |U××••⋄⋄×|•××ux××C|
| ff 45 f0 eb cf 31 c9 8d | 45 87 89 45 e4 8b 45 ec |×E×××1××|E××E××E×|
| 83 f9 03 74 7a 89 4d dc | 31 c9 8b 55 e4 89 55 e0 |××•tz×M×|1××U××U×|
| 83 f9 03 74 46 83 65 e8 | 00 31 db 8b 55 e0 89 55 |××•tF×e×|⋄1××U××U|
| f0 89 4d d8 83 fb 03 74 | 2b 6a fd 5e 85 f6 74 17 |××M×××•t|+j×^××t•|
| 8b 45 f0 0f b6 4c 30 03 | 8d 55 e8 e8 c0 00 00 00 |×E×•×L0•|×U×××⋄⋄⋄|
| 46 a8 01 75 20 eb e5 43 | 83 45 f0 09 8b 45 ec 8b |F×•u ××C|×E×_×E××|
| 4d d8 eb d0 41 83 45 e0 | 03 eb b5 8b 4d dc 41 83 |M×××A×E×|•×××M×A×|
| 45 e4 1b eb 9b 8b 45 ec | 80 3c 38 00 75 0a fe 4c |E×•×××E×|×<8⋄u_×L|
| 3d 87 0f 85 0c ff ff ff | 85 ff 74 7d 4f eb e9 80 |=×•×_×××|××t}O×××|
| 7c 3d 87 00 74 14 83 ff | 50 74 19 47 80 3c 38 00 ||=×⋄t•××|Pt•G×<8⋄|
| 74 08 47 83 ff 51 75 f4 | eb 0a c6 44 3d 87 09 e9 |t•G××Qu×|×_×D=×_×|
| e0 fe ff ff 6a 51 59 8d | 85 35 ff ff ff 8d 75 87 |××××jQY×|×5××××u×|
| 89 c7 f3 a4 89 c6 c6 40 | 51 01 31 c0 31 db 43 89 |×××××××@|Q•1×1×C×|
| 45 f0 83 f8 09 74 32 6a | f7 5f 85 ff 74 16 8a 44 |E×××_t2j|×_××t•×D|
| 3e 09 0c 30 88 45 87 6a | 04 58 8d 4d 87 89 da cd |>__0×E×j|•X×M××××|
| 80 47 eb e6 6a 04 58 b9 | 39 02 01 00 89 da cd 80 |×G××j•X×|9••⋄××××|
| 8b 45 f0 40 83 c6 09 eb | c6 31 c0 40 31 db cd 80 |×E×@××_×|×1×@1×××|
| 84 c9 74 22 55 89 e5 57 | 56 fe c9 31 f6 46 d3 e6 |××t"U××W|V××1×F××|
| 8b 3a 0f b6 c9 b0 01 0f | a3 cf 72 06 09 f7 89 3a |×:•×××••|××r•_××:|
| 31 c0 5e 5f 5d c3 31 c0 | c3 0a                   |1×^_]×1×|×_      |
+-------------------------+-------------------------+--------+--------+
```
