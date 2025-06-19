const std = @import("std");
const rl = @import("raylib");
pub fn main() !void {
    const width: i32 = 1280;
    const height: i32 = 720;
    rl.initWindow(width, height, "Zig Platform Game");
    defer rl.closeWindow();

    var player_pos = rl.Vector2{ .x = width / 2 - 50, .y = height / 2 - 50 };
    var player_vel = rl.Vector2{ .x = 0, .y = 0 };
    var player_grounded: bool = true;

    rl.setTargetFPS(60);
    while (!rl.windowShouldClose()) {
        rl.beginDrawing();
        rl.clearBackground(.black);
        if (rl.isKeyDown(.d)) {
            player_vel.x = 400;
        } else if (rl.isKeyDown(.a)) {
            player_vel.x = -400;
        } else {
            player_vel.x = 0;
        }
        player_vel.y += 2000 * rl.getFrameTime();
        if (player_grounded and rl.isKeyPressed(.space)) {
            player_grounded = false;
            player_vel.y = -900;
        }

        player_pos.x += player_vel.x * rl.getFrameTime();
        player_pos.y += player_vel.y * rl.getFrameTime();
        const screenHeight: f32 = @floatFromInt(rl.getScreenHeight());
        const screenWidth: f32 = @floatFromInt(rl.getScreenWidth());
        if (player_pos.y + 100 > screenHeight) {
            player_grounded = true;
            player_pos.y = screenHeight - 100;
        }
        if (player_pos.x + 100 > screenWidth) {
            player_pos.x = screenWidth - 100;
        }
        if (player_pos.x < 0) {
            player_pos.x = 0;
        }

        rl.drawRectangleV(
            player_pos,
            rl.Vector2{
                .x = 100,
                .y = 100,
            },
            rl.Color{
                .r = 255,
                .g = 0,
                .b = 0,
                .a = 255,
            },
        );
        rl.drawFPS(20, 20);
        rl.endDrawing();
    }
}
