function editor_collision_state(){
	draw_sprite_part(tileset, 0, 0, 0, 62, 62, GAME_W - 63, GAME_H - 63);
		
	var _width = sprite_get_width(tileset) / 16;
	var _height = sprite_get_height(tileset) / 16;
	draw_sprite_part_ext(tileset, 0, (selected_tile mod _width) * 16, floor(selected_tile / _width) * 16,16, 16, GAME_W - 80, GAME_H - 16, 1, 1, #dddddd, 0.75)
		
	if(mouse_check_button(mb_left) && !instance_exists(EditorSaveDialog)){
		
		if(ui_mouse_x > 0){
			if(ui_mouse_y > GAME_H - 63){
				var _click_position_x = floor((ui_mouse_x) / 16);
				var _click_position_y = floor((ui_mouse_y - GAME_H + 63) / 16);
					
				if(_click_position_x >= 0 && _click_position_x < _width && _click_position_y >= 0 && _click_position_y < _height)
					selected_tile = (_click_position_x + _click_position_y * _width);
						
				
			}
		} else {
			var _click_position_x = floor((mouse_x) / 16);
			var _click_position_y = floor((mouse_y) / 16);
				
			log(mouse_x)
				
			if(_click_position_y < 0 || _click_position_x < 0){
				return;
			}
				
			var _bottom_point = (array_length(collision[0]) - 1 > _click_position_y) ? array_length(collision[0]) - 1 : _click_position_y;
				
			for(var w = array_length(collision); w < _click_position_x; w++){
					array_push(collision, [0]);
			}
				
			collision[_click_position_x][_click_position_y] = selected_tile;
				
			for(var w = 0; w < array_length(collision); w++){
				if(array_length(collision[w]) <= _bottom_point)
					collision[w][_bottom_point] = 0;
			}
		}
		//if its below GAME_H - 64, its the tileset
	}
}