for(var set = 0; set < array_length(graphics); set++){
	
	if(graphics[set].tileset == undefined) continue;
	
	tile_width = sprite_get_width(graphics[set].tileset) / 16;
	tile_height = sprite_get_height(graphics[set].tileset) / 16;
	
	for(var w = 0; w < array_length(graphics[set].tiles); w++){
		for(var h = 0; h < array_length(graphics[set].tiles[0]); h++){
			draw_sprite_part(graphics[set].tileset, 0, (graphics[set].tiles[w][h] % tile_width) * 16,floor(graphics[set].tiles[w][h] / tile_width) * 16,16,16,w * 16,h * 16);
		}
	}	
}