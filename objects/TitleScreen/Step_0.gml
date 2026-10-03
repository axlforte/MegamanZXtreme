switch(option_index){
	default:
		if(keyboard_check_pressed(vk_enter)){
			game_end();
		}
	break;
	case(0):
		if(keyboard_check_pressed(vk_enter)){
			room_goto(Room1)
		}
	break;
	case(1):
		if(keyboard_check_pressed(vk_enter) && !instance_exists(EditorLoadDialog)){
			instance_create_depth(0,0,depth - 1, EditorLoadDialog);
		}
	break;
}

if(keyboard_check_pressed(vk_down) && !instance_exists(EditorLoadDialog)){
	option_index = clamp(option_index + 1, 0, 2)
}

if(keyboard_check_pressed(vk_up) && !instance_exists(EditorLoadDialog)){
	option_index = clamp(option_index - 1, 0, 2)
}