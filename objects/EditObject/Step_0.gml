camera_set_view_pos(view_get_camera(view_current), x, y);

renderer.graphics[0].tiles = tiles;
if(state == "collision"){
	renderer.graphics[1].tileset = collision_tiles;
} else {
	renderer.graphics[1].tileset = undefined;
}

if(state == "test") return;

x += (keyboard_check(vk_right) - keyboard_check(vk_left)) * 2 * (1 + keyboard_check(vk_shift) * 1.5);
y += (keyboard_check(vk_down) - keyboard_check(vk_up)) * 2 * (1 + keyboard_check(vk_shift) * 1.5);

player_test_start_x = clamp(player_test_start_x, x + 16,x + GAME_W - 64)
player_test_start_y = clamp(player_test_start_y, y + 8,y + GAME_H - 8)