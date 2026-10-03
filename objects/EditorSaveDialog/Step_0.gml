if (is_active) {
    // Cap the string length if necessary
    if (string_length(keyboard_string) > 20) {
        keyboard_string = string_copy(keyboard_string, 1, 20);
    }
    text_input = keyboard_string;

    // Press Enter to confirm
    if (keyboard_check_pressed(vk_enter)) {
        is_active = false;
        // Trigger your save/submit code here using text_input
		var _editor = instance_nearest(0,0,EditObject);
		
		log(_editor)
		
		global.stage_name = keyboard_string;
		
		JSON.save(new StageData(sprite_get_name(_editor.tileset), _editor.tiles, _editor.collision), working_directory + "/stages/" + global.stage_name + FILE_EXTENSION, true)
		JSON.save(new StageData(sprite_get_name(_editor.tileset), _editor.tiles, _editor.collision), "C:/repos/" + global.stage_name + FILE_EXTENSION, true)
		instance_destroy(self);
    }
}
