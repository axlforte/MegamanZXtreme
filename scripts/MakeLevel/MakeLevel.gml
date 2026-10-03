function MakeLevel(_data){	
	if(instance_exists(EditObject)) return;
	var stage_data = JSON.load("stages/" + _data + ".json");
	
	var _stage = instance_create_depth(0,0,150, TilesetRenderer);
	log("EEEEEEEEEEEEEEEEEEEEE")
	_stage.tiles = stage_data.graphics[0].tiles;
}