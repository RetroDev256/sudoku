# What?
It's a command-line sudoku solver that is made to be ultra tiny. Of course, the page size of many file systems makes a size below 4k no different than any other, but it's still fun to work with :)
The current size of the linux binary is 438 bytes.

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
| 54 00 01 00 62 01 00 00 | 62 01 00 00 07 00 00 00 |T⋄•⋄b•⋄⋄|b•⋄⋄•⋄⋄⋄|
| 00 10 00 00 89 e0 50 e8 | 00 00 00 00 55 89 e5 53 |⋄•⋄⋄××P×|⋄⋄⋄⋄U××S|
| 57 56 83 ec 68 8b 45 08 | 8b 50 08 31 c0 8a 0c 02 |WV××h×E•|×P•1××_•|
| 84 c9 74 0d 80 c1 d0 88 | 0c 02 88 4c 05 8f 40 eb |××t_××××|_•×L•×@×|
| ec 8a 1a 31 c9 b7 03 89 | 55 ec 84 db 0f 84 cd 00 |××•1××•×|U×××•××⋄|
| 00 00 89 c8 89 d6 31 d2 | 6a 09 5f f7 f7 89 cf 89 |⋄⋄××××1×|j__×××××|
| 55 e4 29 d7 8d 14 3e 89 | 55 e8 89 7d e0 29 cf 6a |U×)××•>×|U××}×)×j|
| f7 5e 85 f6 74 14 8d 14 | 37 83 fa f7 74 09 8b 55 |×^××t•×•|7×××t_×U|
| e8 3a 5c 32 09 74 76 46 | eb e8 8b 55 e4 03 55 ec |×:\2_tvF|×××U×•U×|
| 6a af 5f 85 ff 74 10 83 | e8 01 72 06 3a 5c 3a 51 |j×_××t•×|×•r•:\:Q|
| 74 5b 83 c7 09 eb ec 89 | c8 31 d2 6a 1b 5e f7 f6 |t[××_×××|×1×j•^××|
| 89 c2 0f b6 45 e4 f6 f7 | 0f b6 f4 6b c2 1b 8d 14 |××•×E×××|•××k×•×•|
| 01 29 f2 8b 7d e0 29 fa | 01 f7 29 f8 31 f6 03 55 |•)××}×)×|•×)×1×•U|
| ec 83 fe 03 74 46 89 75 | e8 6a fd 5f 85 ff 74 11 |×××•tF×u|×j×_××t•|
| 8d 34 38 83 fe fd 74 06 | 3a 5c 3a 03 74 0f 47 eb |×48×××t•|:\:•t•G×|
| eb 8b 75 e8 46 83 c2 09 | 83 c0 09 eb d4 8b 55 ec |××u×F××_|××_×××U×|
| 80 7c 0d 8f 00 75 0e 8a | 1c 0a fe cb 88 1c 0a 0f |×|_×⋄u•×|•_×××•_•|
| 85 35 ff ff ff 85 c9 74 | 56 49 eb e4 8b 55 ec 80 |×5×××××t|VI×××U××|
| 3c 0a 00 74 08 41 83 f9 | 51 75 f4 eb 0b c6 04 0a |<_⋄t•A××|Qu××•×•_|
| 09 b3 09 e9 12 ff ff ff | 6a af 5e 8d 4d f3 31 db |_×_×•×××|j×^×M×1×|
| 43 6a 09 5f 85 f6 74 27 | 8a 44 32 51 04 30 88 45 |Cj__××t'|×D2Q•0×E|
| f3 6a 04 58 89 da cd 80 | 4f 75 0e c6 45 f3 0a 6a |×j•X××××|Ou•×E×_j|
| 04 58 89 da cd 80 6a 09 | 5f 46 8b 55 ec eb d5 31 |•X××××j_|_F×U×××1|
| c0 40 31 db cd 80       |                         |×@1×××  |        |
+-------------------------+-------------------------+--------+--------+
```
