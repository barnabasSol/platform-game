const std = @import("std");
const rl = @import("raylib");
pub fn main() !void {
    rl.initWindow(1280, 720, "Zig Platform Game");
    defer rl.closeWindow();

    rl.setTargetFPS(60);
    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        rl.clearBackground(.black);
        rl.endDrawing();
    }
}
