const std = @import("std");

pub const Color = @import("vec3.zig").Vec3;

pub fn writeColor(bufOut: anytype, pixelColor: Color) !void {
    const r = pixelColor.x();
    const g = pixelColor.y();
    const b = pixelColor.z();

    const rByte: u8 = @as(u8, @intFromFloat(255.999 * r));
    const gByte: u8 = @as(u8, @intFromFloat(255.999 * g));
    const bByte: u8 = @as(u8, @intFromFloat(255.999 * b));

    try bufOut.print(
        "{d} {d} {d}\n",
        .{ rByte, gByte, bByte },
    );
}
