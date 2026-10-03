function editor_tiles_state(){
	draw_sprite_part(tileset, 0, tileset_offset_x, tileset_offset_y, 62, 62, GAME_W - 63, GAME_H - 63);
		
	var _width = sprite_get_width(tileset) / 16;
	var _height = sprite_get_height(tileset) / 16;
	//draw selected tile
	draw_sprite_part_ext(tileset, 0, (selected_tile mod _width) * 16, floor(selected_tile / _width) * 16,16, 16, GAME_W - 80, GAME_H - 16, 1, 1,#dddddd, 0.75)
		
	draw_sprite(zx_editor_arrows, 1, GAME_W - 63,  GAME_H - 80);
	draw_sprite(zx_editor_arrows, 0, GAME_W - 47,  GAME_H - 80);
	draw_sprite(zx_editor_arrows, 3, GAME_W - 55,  GAME_H - 88);
	draw_sprite(zx_editor_arrows, 2, GAME_W - 55,  GAME_H - 72);
		
	if(mouse_check_button(mb_left) && !instance_exists(EditorSaveDialog)){
		
		if(ui_mouse_x > 0){
			if(ui_mouse_y > GAME_H - 63){
				var _click_position_x = floor((ui_mouse_x + tileset_offset_x) / 16);
				var _click_position_y = floor((ui_mouse_y - GAME_H + 63 + tileset_offset_y) / 16);
					
				if(_click_position_x >= 0 && _click_position_x < _width && _click_position_y >= 0 && _click_position_y < _height)
					selected_tile = (_click_position_x + _click_position_y * _width);
						
				
			} else if(mouse_check_button_pressed(mb_left)){ 
				if(0 < ui_mouse_x && ui_mouse_x < 8 && (GAME_H - 80) < ui_mouse_y && ui_mouse_y < (GAME_H - 72)){
					log("LEFT")
					tileset_offset_x -= 8;
					tileset_offset_x = max(tileset_offset_x, -40)
				} else if(16 < ui_mouse_x && ui_mouse_x < 24 && (GAME_H - 80) < ui_mouse_y && ui_mouse_y < (GAME_H - 72)) {
					log("RIGHT")
					tileset_offset_x += 8;
					tileset_offset_x = min(tileset_offset_x, sprite_get_width(tileset) - 8)
				} else if(8 < ui_mouse_x && ui_mouse_x < 16 && (GAME_H - 88) < ui_mouse_y && ui_mouse_y < (GAME_H - 80)) {
					log("UP")
					tileset_offset_y -= 8;
					tileset_offset_y = max(tileset_offset_y, -40)
				} else if(8 < ui_mouse_x && ui_mouse_x < 16 && (GAME_H - 72) < ui_mouse_y && ui_mouse_y < (GAME_H - 64)) {
					log("DOWN")
					tileset_offset_y += 8;
					tileset_offset_y = min(tileset_offset_y, sprite_get_height(tileset) - 8)
				}
			}
		} else {
			var _click_position_x = floor((mouse_x) / 16);
			var _click_position_y = floor((mouse_y) / 16);
				
			log(mouse_x)
				
			if(_click_position_y < 0 || _click_position_x < 0){
				return;
			}
				
			var _bottom_point = (array_length(tiles[0]) - 1 > _click_position_y) ? array_length(tiles[0]) - 1 : _click_position_y;
				
			for(var w = array_length(tiles); w < _click_position_x; w++){
					array_push(tiles, [0]);
			}
				
			tiles[_click_position_x][_click_position_y] = selected_tile;
				
			for(var w = 0; w < array_length(tiles); w++){
				if(array_length(tiles[w]) <= _bottom_point)
					tiles[w][_bottom_point] = 0;
			}
		}
		//if its below GAME_H - 64, its the tileset
	}
}