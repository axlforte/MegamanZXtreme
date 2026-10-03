tileset = napalm_man_tileset;

state = "tiles";

ui_mouse_x = 0;
ui_mouse_y = 0;

tileset_offset_x = 0;
tileset_offset_y = 0;

player_test_start_x = 0;
player_test_start_y = 0;

tiles = [[0]]
collision = [[0]]
selected_tile = 0;

tileset_options = [
	napalm_man_tileset,
	StrikeManTileset
]

if(global.stage_name != undefined){
	var _stage = JSON.load(working_directory + "/stages/" + global.stage_name + FILE_EXTENSION);
	if(variable_struct_get(_stage, "graphics") != undefined){
		tiles = _stage.graphics[0].tiles;
		collision = _stage.collision;
		var _set = _stage.graphics[0].tileset;
	
		for(var t = 0; t < array_length(tileset_options); t++){
			if(sprite_get_name(tileset_options[t]) == _set)
				tileset = tileset_options[t];
			else
			log(sprite_get_name(tileset_options[t]))
		}
	}
}


renderer = instance_create_depth(x,y,depth - 1, TilesetRenderer);

renderer.graphics[0].tileset = tileset;

renderer.graphics[1] = variable_clone(renderer.graphics[0]);

renderer.graphics[1].tiles = collision;

log(renderer.graphics[0].tileset)