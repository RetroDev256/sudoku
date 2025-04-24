pub export fn _start() callconv(.naked) noreturn {
    asm volatile (
        \\ xorl %%ebp, %%ebp
        \\ movl %%esp, %%eax
        \\ andl $-16, %%esp
        \\ subl $12, %%esp
        \\ pushl %%eax
        \\ calll %[posixMainAndExit:P]
        :
        : [_start] "X" (&_start),
          [posixMainAndExit] "X" (&posixMainAndExit),
    );
}

fn posixMainAndExit(argc_argv_ptr: [*]usize) callconv(.c) noreturn {
    // const argc = argc_argv_ptr[0];
    const argv: [*][*:0]u8 = @ptrCast(argc_argv_ptr + 1);

    var cell = argv[1];
    while (cell[0] != 0) {
        cell[0] -= '0';
        cell += 1;
    }

    if (solve(argv[1][0..81])) {
        try render(argv[1][0..81].*);
    }

    std.process.exit(0);
}

const std = @import("std");
const assert = std.debug.assert;

// Backtracking sudoku solver
fn solve(state: *[81]u8) bool {
    const grid: [81]u8 = state.*;
    var current: u32 = 0;

    while (true) {
        if (check(state)) {
            // move forward to the next non-zero cell
            if (state[current] != 0) {
                if (current == 80) {
                    return true; // found solution
                } else {
                    current += 1;
                    // skip cells we can't change
                    while (grid[current] != 0) {
                        if (current == 80) {
                            return true; // found solution
                        } else {
                            current += 1;
                        }
                    }
                }
            }

            // update the cell
            assert(state[current] == 0);
            state[current] = 9;
        } else {
            backtrack: while (true) {
                // search for the last cell which we can change
                while (grid[current] != 0) {
                    if (current == 0) {
                        return false; // no solution
                    } else {
                        current -= 1;
                    }
                }

                // reduce the cell
                assert(state[current] > 0);
                state[current] -= 1;

                // stop backtracking when we are in a stable state
                if (state[current] != 0) {
                    break :backtrack;
                } else {
                    if (current == 0) {
                        return false; // no solution
                    } else {
                        current -= 1;
                    }
                }
            }
        }
    }
}

fn render(grid: [81]u8) !void {
    for (0..9) |row| {
        for (0..9) |col| {
            const val = grid[col + row * 9];
            assert(val > 0 and val < 10);
            putstr(&.{'0' + val});
        }
        putstr("\n");
    }
}

// Print a string at cursor - can fail, but likely won't
fn putstr(str: []const u8) void {
    assert(std.os.linux.write(1, str.ptr, str.len) == str.len);
}

// return true on success - ignore cells == 0
fn check(grid: *const [81]u8) bool {
    return lines(grid) and blocks(grid);
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
