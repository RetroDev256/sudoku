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

        while (check(state, current)) {
            // search for a cell we can change
            while (state[current] != 0) {
                current += 1;
                if (current == 81) {
                    return true;
                }
            }

            state[current] = 9;
        }

        backtrack: while (true) {
            // skip back to a cell we can change
            while (grid[current] != 0) {
                current -%= 1;
                if (~current == 0) {
                    return false;
                }
            }

            // change the cell
            assert(grid[current] == 0);
            assert(state[current] != 0);
            state[current] -= 1;

            // make sure we are in a stable state
            if (state[current] == 0) {
                current -%= 1;
                if (~current == 0) {
                    return false;
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

// return true on success - skip cells == 0
fn check(grid: *const [81]u8, idx: u32) bool {
    if (grid[idx] == 0) return true;
    return lines(grid, idx) and blocks(grid, idx);
}

fn lines(grid: *const [81]u8, idx: u32) bool {
    const row = idx / 9;
    const col = idx % 9;

    for (0..9) |cmp| {
        if (cmp != col) {
            const cmp_idx = cmp + row * 9;
            if (grid[idx] == grid[cmp_idx]) {
                return false;
            }
        }

        if (cmp != row) {
            const cmp_idx = col + cmp * 9;
            if (grid[idx] == grid[cmp_idx]) {
                return false;
            }
        }
    }

    return true;
}

fn blocks(grid: *const [81]u8, idx: u32) bool {
    const block_row = (idx / 9) / 3;
    const block_col = (idx % 9) / 3;

    for (0..3) |cmp_row_off| {
        for (0..3) |cmp_col_off| {
            const cmp_row = cmp_row_off + block_row * 3;
            const cmp_col = cmp_col_off + block_col * 3;
            const cmp_idx = cmp_col + cmp_row * 9;
            if (cmp_idx == idx) continue;
            if (grid[idx] == grid[cmp_idx]) {
                return false;
            }
        }
    }

    return true;
}
