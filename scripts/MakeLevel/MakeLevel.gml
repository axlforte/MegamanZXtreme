function MakeLevel(_data){
	
	JSON.save({
		graphics: [
			{
				tileset: "strikeman.png",
				tiles: [[0,0], [0,0]]
			}
		]
	
	}, "strikeman_intro");
	
	
	
	
	stage_data = JSON.load(_data);
}