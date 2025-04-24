# What?
It's a command-line sudoku solver that is made to be ultra tiny. Of course, the page size of many file systems makes a size below 4k no different than any other, but it's still fun to work with :)
The current size of the linux binary is 507 bytes.

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
| 54 00 01 00 a7 01 00 00 | a7 01 00 00 07 00 00 00 |T⋄•⋄×•⋄⋄|×•⋄⋄•⋄⋄⋄|
| 00 10 00 00 89 e0 50 e8 | 00 00 00 00 55 89 e5 53 |⋄•⋄⋄××P×|⋄⋄⋄⋄U××S|
| 57 56 83 ec 70 8b 55 08 | 8b 42 08 8a 08 84 c9 74 |WV××p×U•|×B•×•××t|
| 08 80 c1 d0 88 08 40 eb | f2 8b 72 08 6a 51 59 8d |•××××•@×|××r•jQY×|
| 7d 87 89 75 f0 f3 a4 31 | f6 8b 55 f0 31 c0 83 f8 |}××u×××1|××U×1×××|
| 09 74 6a 31 c9 89 55 ec | 89 45 d8 39 c1 74 5a 31 |_tj1××U×|×E×9×tZ1|
| db 89 4d e8 83 fb 09 74 | 4d 8d 3c db 01 f8 89 45 |××M×××_t|M×<×•××E|
| dc 01 cf 89 7d e0 89 5d | e4 83 eb 01 72 29 8b 45 |×•××}××]|×××•r)×E|
| f0 8b 4d dc 8a 04 08 84 | c0 74 17 8b 4d f0 8b 7d |××M××••×|×t•×M××}|
| e0 3a 04 39 0f 84 97 00 | 00 00 3a 02 0f 84 8f 00 |×:•9•××⋄|⋄⋄:••××⋄|
| 00 00 83 c2 09 eb d2 8b | 5d e4 43 8b 55 ec 8b 45 |⋄⋄××_×××|]×C×U××E|
| d8 8b 4d e8 eb ae 41 eb | a2 40 42 eb 91 31 c0 8b |××M×××A×|×@B××1××|
| 4d f0 83 f8 03 74 7f 31 | d2 89 cf 89 45 e8 89 4d |M×××•t•1|××××E××M|
| ec 83 fa 03 74 4c 89 55 | e0 31 c0 89 7d e4 31 db |×××•tL×U|×1××}×1×|
| 83 f8 03 74 2b 89 45 dc | 6a fd 5a 85 d2 74 18 0f |××•t+×E×|j×Z××t••|
| b6 4c 17 03 85 c9 74 0c | 31 c0 40 d3 e0 0f a3 cb |×L••××t_|1×@××•××|
| 72 2f 09 c3 42 eb e4 8b | 45 dc 40 83 c7 09 eb d0 |r/_×B×××|E×@××_××|
| 8b 55 e0 42 8b 7d e4 83 | c7 03 8b 45 e8 8b 4d ec |×U×B×}××|×•×E××M×|
| eb af 40 83 c1 1b eb 9a | 85 f6 0f 84 84 00 00 00 |××@××•××|××•××⋄⋄⋄|
| 4e 80 7c 35 87 00 75 f0 | 8b 45 f0 fe 0c 30 0f 85 |N×|5×⋄u×|×E××_0•×|
| 05 ff ff ff eb e2 8b 45 | f0 80 3c 30 00 74 15 83 |•××××××E|××<0⋄t•×|
| fe 50 74 1c 46 80 7c 35 | 87 00 74 08 46 83 fe 51 |×Pt•F×|5|×⋄t•F××Q|
| 75 f3 eb 0c 8b 45 f0 c6 | 04 30 09 e9 d9 fe ff ff |u××_×E××|•0_×××××|
| 8b 45 08 8b 78 08 31 c0 | 8d 4d 87 31 db 43 83 f8 |×E•×x•1×|×M×1×C××|
| 09 74 31 89 45 f0 6a f7 | 5e 85 f6 74 13 8a 44 37 |_t1×E×j×|^××t•×D7|
| 09 0c 30 88 45 87 6a 04 | 58 89 da cd 80 46 eb e9 |__0×E×j•|X××××F××|
| c6 45 87 0a 6a 04 58 89 | da cd 80 8b 45 f0 40 83 |×E×_j•X×|××××E×@×|
| c7 09 eb ca 31 c0 40 31 | db cd 80                |×_××1×@1|×××     |
+-------------------------+-------------------------+--------+--------+
```
