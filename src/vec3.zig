const std = @import("std");
const math = std.math;

pub const Vec3 = struct {
    e: [3]f64,

    pub fn init(e0: f64, e1: f64, e2: f64) Vec3 {
        return .{ .e = .{ e0, e1, e2 } };
    }

    pub fn zero() Vec3 {
        return .{ .e = .{ 0, 0, 0 } };
    }

    pub fn x(self: Vec3) f64 {
        return self.e[0];
    }

    pub fn y(self: Vec3) f64 {
        return self.e[1];
    }

    pub fn z(self: Vec3) f64 {
        return self.e[2];
    }

    pub fn negate(self: Vec3) Vec3 {
        return Vec3.init(-self.e[0], -self.e[1], -self.e[2]);
    }

    pub fn get(self: Vec3, i: usize) f64 {
        return self.e[i];
    }

    pub fn getPtr(self: *Vec3, i: usize) *f64 {
        return &self.e[i];
    }

    pub fn add(self: *Vec3, v: Vec3) void {
        self.e[0] += v.e[0];
        self.e[1] += v.e[1];
        self.e[2] += v.e[2];
    }

    pub fn scale(self: *Vec3, t: f64) void {
        self.e[0] *= t;
        self.e[1] *= t;
        self.e[2] *= t;
    }

    pub fn divide(self: *Vec3, t: f64) void {
        self.scale(1 / t);
    }

    pub fn length(self: Vec3) f64 {
        return math.sqrt(self.lengthSquared());
    }

    pub fn lengthSquared(self: Vec3) f64 {
        return self.e[0] * self.e[0] + self.e[1] * self.e[1] + self.e[2] * self.e[2];
    }
};

pub const Point3 = Vec3;

// Vector Utility Functions

pub fn print(writer: std.io.GenericWriter, v: Vec3) !void {
    try writer.print("{d} {d} {d}", .{ v.e[0], v.e[1], v.e[2] });
}

pub fn add(u: Vec3, v: Vec3) Vec3 {
    return Vec3.init(u.e[0] + v.e[0], u.e[1] + v.e[1], u.e[2] + v.e[2]);
}

pub fn subtract(u: Vec3, v: Vec3) Vec3 {
    return Vec3.init(u.e[0] - v.e[0], u.e[1] - v.e[1], u.e[2] - v.e[2]);
}

pub fn multiply(u: Vec3, v: Vec3) Vec3 {
    return Vec3.init(u.e[0] * v.e[0], u.e[1] * v.e[1], u.e[2] * v.e[2]);
}

pub fn scaleVec(t: f64, v: Vec3) Vec3 {
    return Vec3.init(t * v.e[0], t * v.e[1], t * v.e[2]);
}

pub fn divideVec(v: Vec3, t: f64) Vec3 {
    return scaleVec(1 / t, v);
}

pub fn dot(u: Vec3, v: Vec3) f64 {
    return u.e[0] * v.e[0] + u.e[1] * v.e[1] + u.e[2] * v.e[2];
}

pub fn cross(u: Vec3, v: Vec3) Vec3 {
    return Vec3.init(u.e[1] * v.e[2] - u.e[2] * v.e[1], u.e[2] * v.e[0] - u.e[0] * v.e[2], u.e[0] * v.e[1] - u.e[1] * v.e[0]);
}

pub fn unitVector(v: Vec3) Vec3 {
    return divideVec(v, v.length());
}
