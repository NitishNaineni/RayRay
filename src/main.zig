const std = @import("std");
const color = @import("color.zig");

pub fn main() !void {
    const image_width: usize = 2048;
    const image_height: usize = 2048;

    const progress_node = std.Progress.start(.{
        .root_name = "rendering pixels",
        .estimated_total_items = image_width * image_height,
    });
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
            const pixel = color.Color.init(
                @as(f32, @floatFromInt(i)) / (image_width - 1),
                @as(f32, @floatFromInt(j)) / (image_height - 1),
                0.0,
            );

            try color.writeColor(bufOut, pixel);
            progress_node.completeOne();
        }
    }
    try buffer.flush();
}
