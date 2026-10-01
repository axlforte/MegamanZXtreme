function Autotile(){
	var tile_layer = layer_tilemap_get_id("collision");
	
	for(var w = 0; w < room_width / 16; w++){
		for(var h = 0; h < room_height / 16; h++){
			
			if(tilemap_get(tile_layer, w, h) == 11 && !instance_position(w * 16, h * 16, Collision)){
				var _x_length = 1;
				var _coll = instance_create_depth(w * 16, h * 16, 0, Collision);
			
				while(tilemap_get(tile_layer, w + _x_length, h) == 11){
					_coll.image_xscale++;
					_x_length++;
				}
				
				if(instance_position(_coll.x, _coll.y - 16, Collision)  && true == false){
					var _y_length = 1;
					var stay = true;
					while(instance_position(_coll.x, _coll.y - _y_length * 16, Collision) && stay){
						var _tile = instance_position(_coll.x, _coll.y - _y_length * 16, Collision);
						
						if(_tile.image_xscale != _coll.image_xscale){
							stay = false;
						} else {
							instance_destroy(instance_position(_coll.x, _coll.y - _y_length * 16, Collision));
						
							_coll.image_yscale++;
							_coll.y -= 16;
							_y_length++;
						}
					}
				}
			} else if(tilemap_get(tile_layer, w, h) == 2 && !instance_position(w * 16, h * 16, Collision)){
				var _x_length = 1;
				var _coll = instance_create_depth(w * 16, h * 16, 0, Collision);
				_coll.image_yscale = 0.5;
			
				while(tilemap_get(tile_layer, w + _x_length, h) == 2){
					_coll.image_xscale++;
					_x_length++;
				}
			} else if(tilemap_get(tile_layer, w, h) == 10 && !instance_position(w * 16, h * 16, Collision)){
				var _x_length = 1;
				var _coll = instance_create_depth(w * 16, h * 16, 0, Collision);
				_coll.image_yscale = 0.5;
				_coll.y += 8;
			
				while(tilemap_get(tile_layer, w + _x_length, h) == 10){
					_coll.image_xscale++;
					_x_length++;
				}
			} else if(tilemap_get(tile_layer, w, h) == 5){
				var _x_length = 1;
				var _coll = instance_create_depth(w * 16, h * 16, 0, Collision_Slope_Top_Left);
			} else if(tilemap_get(tile_layer, w, h) == 4){
				var _x_length = 1;
				var _coll = instance_create_depth(w * 16, h * 16, 0, Collision_Slope_Bottom_Left);
			} else if(tilemap_get(tile_layer, w, h) == 8){
				var _x_length = 1;
				var _coll = instance_create_depth(w * 16, h * 16, 0, Collision_Slope_Top);
			} else if(tilemap_get(tile_layer, w, h) == 9){
				var _x_length = 1;
				var _coll = instance_create_depth(w * 16, h * 16, 0, Collision_Slope_Bottom);
			} else {
				
			}
			//eof
		}
	}
}