const std = @import("std");
const glfw = @import("../../libs/mach-glfw/build.zig");
const gpu = @import("../../libs/mach-gpu/build.zig");
const zgpu = @import("../../libs/zgpu/build.zig");

const Options = @import("../../build.zig").Options;
const content_dir = "triangle_wgpu_content/";

pub fn build(b: *std.build.Builder, options: Options) *std.build.LibExeObjStep {
    const exe = b.addExecutable("triangle_wgpu", thisDir() ++ "/src/triangle_wgpu.zig");

    exe.setBuildMode(options.build_mode);
    exe.setTarget(options.target);
    exe.addPackage(glfw.pkg);
    exe.addPackage(gpu.pkg);
    exe.addPackage(zgpu.pkg);

    zgpu.link(b, exe, .{
        .glfw_options = .{},
        .gpu_dawn_options = .{ .from_source = options.dawn_from_source },
    });

    return exe;
}

fn thisDir() []const u8 {
    return std.fs.path.dirname(@src().file) orelse ".";
}
