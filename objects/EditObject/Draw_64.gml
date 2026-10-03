//init the mouse positions
ui_mouse_x = mouse_x - GAME_W + 64 - x;

ui_mouse_y = mouse_y - y;

//draw the boundaries
if(state != "test"){
	draw_sprite(zx_editor_arrows, 0, -x - 8, -y);
	draw_sprite(zx_editor_arrows, 0, -x - 8, -y + array_length(tiles[0]) * 16 - 8);

	draw_sprite(zx_editor_arrows, 1, -x + array_length(tiles) * 16, -y);
	draw_sprite(zx_editor_arrows, 1, -x + array_length(tiles) * 16, -y + array_length(tiles[0]) * 16 - 8);

	draw_sprite_ext(zx_pointer, 0, player_test_start_x - x, player_test_start_y - y, 1, 1, 0, c_white, 1)

	//draw the item selection box
	draw_set_color(#222233);
	draw_rectangle(GAME_W - 64, 0, GAME_W, GAME_H, false);
	//draw the item editor box
	draw_set_color(c_black);
	draw_rectangle(GAME_W - 63, GAME_H - 64, GAME_W, GAME_H, false);

	//draw all of the tool icons
	for(var p = 0; p < sprite_get_number(editor_icons); p++){
		if(ui_mouse_x > (p * 12 + 4) && ui_mouse_x < (p * 12 + 12) && ui_mouse_y < 12){
			draw_sprite(editor_icons, p, GAME_W - 64 + p * 12, 0)
			if(mouse_check_button_pressed(mb_left))
				switch(p){
					case(0):
						instance_create_depth(x + 32, x + 32, depth - 1, EditorSaveDialog);
					break;
					case(1):
						state = "test"
					
						for(var g = 0; g < array_length(collision); g++){
							for(var d = 0; d <array_length(collision[0]); d++){
								tilemap_set(layer_tilemap_get_id("Collision"), collision[g][d], g, d)
								log("set da tileset")
							}
						}
						
						global.room_height = array_length(collision[0]);
						global.room_width = array_length(collision);
					
						instance_create_depth(player_test_start_x, player_test_start_y, 0, player)
					break;
					case(2):
						state = "tiles"
						tileset = renderer.graphics[0].tileset;
					break;
					case(3):
						state = "collision"
						tileset = collision_tiles;
					break;
					default:
						log("Not implemented!");
					break;
				}
		} else
			draw_sprite_ext(editor_icons, p, GAME_W - 64 + p * 12, 0, 1, 1, 0, #888888, 1);
	}

	//draw state
	switch(state){
		case("tiles"):
			editor_tiles_state();
		break;
		case("collision"):
			editor_collision_state();
		break;
	}

}