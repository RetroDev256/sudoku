const std = @import("std");
const assert = std.debug.assert;

pub export fn _start() callconv(.naked) noreturn {
    asm volatile (
        \\ movl %%esp, %%eax
        \\ pushl %%eax
        \\ calll %[posixMainAndExit:P]
        :
        : [_start] "X" (&_start),
          [posixMainAndExit] "X" (&posixMainAndExit),
    );
}

fn posixMainAndExit(argc_argv_ptr: [*]usize) callconv(.c) noreturn {
    const argc = argc_argv_ptr[0];
    assert(argc == 2);

    const argv_ptr: [*][*:0]u8 = @ptrCast(argc_argv_ptr + 1);
    const input = argv_ptr[1];
    var grid: [81]u8 = undefined;

    var in_ptr = input;
    var grid_ptr: [*]u8 = &grid;
    while (in_ptr[0] != 0) {
        assert(in_ptr[0] <= '9');
        assert(in_ptr[0] >= '0');
        in_ptr[0] -= '0';
        grid_ptr[0] = in_ptr[0];
        in_ptr += 1;
        grid_ptr += 1;
    }

    if (solve(grid, input[0..81])) {
        for (input[0..81]) |cell| {
            assert(cell >= 1 and cell <= 9);
        }
        render(input[0..81]);
    }

    std.process.exit(0);
}

// Backtracking sudoku solver
fn solve(grid: [81]u8, state: *[81]u8) bool {
    var current: u32 = 0;

    while (true) {
        for (state[0..current]) |cell| {
            assert(cell >= 1 and cell <= 9);
        }

        while (check(state)) {
            // search for a cell we can change
            while (state[current] != 0) {
                if (current == 80) {
                    return true;
                } else {
                    current += 1;
                }
            }

            state[current] = 9;
        }

        backtrack: while (true) {
            // skip back to a cell we can change
            while (grid[current] != 0) {
                if (current == 0) {
                    return false;
                } else {
                    current -= 1;
                }
            }

            // change the cell
            assert(grid[current] == 0);
            assert(state[current] != 0);
            state[current] -= 1;

            // make sure we are in a stable state
            if (state[current] == 0) {
                if (current == 0) {
                    return false;
                } else {
                    current -= 1;
                }
            } else {
                break :backtrack;
            }
        }
    }
}

fn render(grid: *const [81]u8) void {
    var idx: u32 = 0;
    var col: u32 = 9;
    while (idx < 81) {
        putByte('0' + grid[idx]);

        idx += 1;
        col -= 1;

        if (col == 0) {
            putByte('\n');
            col = 9;
        }
    }
}

// Print a byte
fn putByte(byte: u8) void {
    const str: *const [1]u8 = &byte;
    assert(std.os.linux.write(1, str, 1) == 1);
}

// return true on success - ignore cells == 0
fn check(grid: *const [81]u8) bool {
    return blocks(grid) and lines(grid);
}

// return true on success - ignore cells == 0
fn lines(grid: *const [81]u8) bool {
    for (0..9) |col_a| {
        for (0..col_a) |col_b| {
            for (0..9) |row_a| {
                for (0..row_a) |row_b| {
                    const idx = col_a + row_a * 9;
                    if (grid[idx] == 0) continue;

                    const row_idx = col_b + row_a * 9;
                    if (grid[idx] == grid[row_idx]) {
                        return false;
                    }

                    const col_idx = col_a + row_b * 9;
                    if (grid[idx] == grid[col_idx]) {
                        return false;
                    }
                }
            }
        }
    }

    return true;
}

// return true on success - ignore cells == 0
fn blocks(grid: *const [81]u8) bool {
    for (0..3) |b_row| {
        for (0..3) |b_col| {
            var mask: u32 = 0;
            for (0..3) |sub_row| {
                for (0..3) |sub_col| {
                    const row = sub_row + b_row * 3;
                    const col = sub_col + b_col * 3;
                    const idx = col + row * 9;
                    if (grid[idx] == 0) continue;

                    const shift: u5 = @intCast(grid[idx]);

                    if ((mask >> shift) & 1 == 1) {
                        return false;
                    } else {
                        mask |= @as(u32, 1) << shift;
                    }
                }
            }
        }
    }

    return true;
}
