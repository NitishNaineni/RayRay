const std = @import("std");

pub fn main() !void {
    const image_width: usize = 2048;
    const image_height: usize = 2048;

    const parent_progress_node = std.Progress.start(.{});
    const progress_node = parent_progress_node.start(
        "rendering pixels",
        image_width * image_height,
    );
    defer progress_node.end();

    const stdout = std.io.getStdOut().writer();
    var buffer = std.io.bufferedWriter(stdout);

    const bufOut = buffer.writer();

    try bufOut.print(
        "P3\n{d} {d}\n255\n",
        .{ image_width, image_height },
    );

    for (0..image_height) |j| {
        for (0..image_width) |i| {
            const r: f32 = @as(f32, @floatFromInt(i)) / (image_width - 1);
            const g: f32 = @as(f32, @floatFromInt(j)) / (image_height - 1);
            const b: f32 = 0.0;

            const ir: u8 = @as(u8, @intFromFloat(255.999 * r));
            const ig: u8 = @as(u8, @intFromFloat(255.999 * g));
            const ib: u8 = @as(u8, @intFromFloat(255.999 * b));

            try bufOut.print(
                "{d} {d} {d}\n",
                .{ ir, ig, ib },
            );

            progress_node.completeOne();
        }
    }
    try buffer.flush();
}
