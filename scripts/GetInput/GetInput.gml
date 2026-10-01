function Input() constructor{
	binds = [
		new InputAction("jump", ord("V")),
		new InputAction("dash", ord("D")),
		new InputAction("shoot", ord("X")),
		new InputAction("alt shoot", ord("C")),
		new InputAction("up", vk_up),
		new InputAction("down", vk_down),
		new InputAction("left", vk_left),
		new InputAction("right", vk_right),
		new InputAction("weapon L", ord("A")),
		new InputAction("weapon R", ord("S")),
		new InputAction("giga", ord("F")),
	];
	
	pressed = [];
	held = [];
	
	init = function(){
		pressed = array_create(array_length(binds), false);
		held = array_create(array_length(binds), false);
	}
	
	update = function(){
		array_foreach(held, function(_element, _index){
			held[_index] = keyboard_check(binds[_index].keybind);
		})
		array_foreach(pressed, function(_element, _index){
			pressed[_index] = keyboard_check_pressed(binds[_index].keybind);
		})
	}
	
	get_held = function(_input){
		for(var t = 0; t < array_length(binds); t++){
			if(binds[t].title == _input && held[t] == true)
				return true;
		}
		return false;
	}
	
	get_pressed = function(_input){
		for(var t = 0; t < array_length(binds); t++){
			if(binds[t].title == _input && pressed[t] == true)
				return true;
		}
		return false;
	}
}

function InputAction(_name, _key) constructor{
	title = _name;
	keybind = _key;
}