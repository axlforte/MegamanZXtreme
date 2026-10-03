if (is_active) {
    // Cap the string length if necessary
    if (string_length(keyboard_string) > 20) {
        keyboard_string = string_copy(keyboard_string, 1, 20);
    }
    text_input = keyboard_string;
	string_replace(keyboard_string, " ", "")

    // Press Enter to confirm
    if (keyboard_check_pressed(vk_enter)) {
		global.stage_name = text_input;
        room_goto(Editor);
    }
}
