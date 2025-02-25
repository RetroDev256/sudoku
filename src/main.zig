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

    var grid: [81]u8 = undefined;
    for (&grid, argv[1]) |*cell, byte| {
        cell.* = @intCast(byte - '0');
    }

    if (solve(grid)) |solved| {
        try render(solved);
    }

    std.process.exit(0);
}

const std = @import("std");
const assert = std.debug.assert;

// Backtracking sudoku solver
fn solve(grid: [81]u8) ?[81]u8 {
    var state: [81]u8 = grid;
    var current: u7 = 0;

    while (true) {
        if (check(state)) {
            // move forward to the next non-zero cell
            if (state[current] != 0) {
                if (current == 80) {
                    return state; // found solution
                } else {
                    current += 1;
                    // skip cells we can't change
                    while (grid[current] != 0) {
                        if (current == 80) {
                            return state; // found solution
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
                        return null; // no solution
                    } else {
                        current -= 1;
                    }
                }

                // reduce the cell
                assert(state[current] > 0);
                state[current] -= 1;

                // stop backtracking when we are in a stable state
                if (state[current] > 0) {
                    break :backtrack;
                } else {
                    if (current == 0) {
                        return null; // no solution
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
fn check(grid: [81]u8) bool {
    return rows(grid) and cols(grid) and blocks(grid);
}

// return true on success - ignore cells == 0
fn rows(grid: [81]u8) bool {
    for (0..9) |row| {
        var mask: u9 = 0;
        for (0..9) |col| {
            const idx = col + row * 9;
            if (testMask(grid[idx], &mask)) {
                return false;
            }
        }
    }
    return true;
}

// return true on success - ignore cells == 0
fn cols(grid: [81]u8) bool {
    for (0..9) |col| {
        var mask: u9 = 0;
        for (0..9) |row| {
            const idx = col + row * 9;
            if (testMask(grid[idx], &mask)) {
                return false;
            }
        }
    }
    return true;
}

// return true on success - ignore cells == 0
fn blocks(grid: [81]u8) bool {
    for (0..3) |b_row| {
        for (0..3) |b_col| {
            var mask: u9 = 0;
            for (0..3) |sub_row| {
                for (0..3) |sub_col| {
                    const row = sub_row + b_row * 3;
                    const col = sub_col + b_col * 3;
                    const idx = col + row * 9;
                    if (testMask(grid[idx], &mask)) {
                        return false;
                    }
                }
            }
        }
    }
    return true;
}

// return true if the mask already contains that value
fn testMask(val: u8, mask: *u9) bool {
    if (val != 0) {
        const shift: u4 = @intCast(val - 1);
        const bit = @as(u9, 1) << shift;
        if (mask.* & bit != 0) {
            return true;
        } else {
            mask.* |= bit;
        }
    }
    return false;
}
