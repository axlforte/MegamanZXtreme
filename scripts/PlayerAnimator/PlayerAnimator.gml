function PAnim_Step(){
	var _temp = "idle"
	anim_timer++;
	
	if(snes_physics.grounded){
		if(abs(snes_physics.hspd) > player_data.walkSpeed)
			_temp = "dash";
		else if(abs(snes_physics.hspd) > 0)
			_temp = "walk"
	} else {
		if(snes_physics.vspd > 0)
			_temp = "fall"
		else 
			_temp = "jump"
			
		if(snes_physics.can_wall_jump == true && snes_physics.hspd != 0)
			_temp = "wall"
	}
	
	if(invuln_time > 0 && invuln_time < 16)
		_temp = "hurt"
	
	if(anim_name != _temp){
		anim_name = _temp;
		anim_timer = 0;
		anim_looped = false;
	}
}

function PAnim_Draw(_x, _y, _color = c_white){
	var _index = 0;
	for(var p = 0; p < array_length(animations); p++){
		if(animations[p].title == anim_name)
			_index = p;
	}
	
	var _frame = 0;
	
	if(animations[_index].loops){
		if(anim_looped == false && anim_timer > array_last(animations[_index].frames)){
			anim_looped = true;
		}
		
		if(anim_timer > array_last(animations[_index].frames)){
			anim_timer = animations[_index].loop_point;
		}
		
		for(var r = 0; r < array_length(animations[_index].frames); r++){
			if(anim_timer > animations[_index].frames[r])
				_frame++;
		}
		
	} else if(anim_timer > array_last(animations[_index].frames)){
		_frame = array_length(animations[_index].frames) - 1;
	} else {
		for(var r = 0; r < array_length(animations[_index].frames); r++){
			if(anim_timer > animations[_index].frames[r])
				_frame++;
		}
	}
	
	
	_frame = clamp(_frame, 0, array_length(animations[_index].frames) - 1);
	
	draw_sprite_ext(animations[_index].sprite_reference, _frame, _x, _y, snes_physics.facing_direction, 1, 0, _color, 1);
}

function PAnim_Init(){
	anim_timer = 0;
	anim_looped = false;
	anim_name = "idle";
	
	animations = [
		new PAnim_Define("idle", [0], x_idle),
		new PAnim_Define("walk", [0, 4, 8, 12, 16, 20, 24, 28, 32], x_walk, true, 1),
		new PAnim_Define("jump", [3, 7, 10], x_jump),
		new PAnim_Define("fall", [2, 4, 7], x_fall),
		new PAnim_Define("wall", [3, 5], x_wall),
		new PAnim_Define("wall_jump", [1, 3, 4], x_wall_jump),
		new PAnim_Define("dash", [2, 4], x_dash),
		new PAnim_Define("hurt", [1, 2, 3], x_hurt, true),
	]
}

//frames refers to the point after the animation starts when the frame changes to the next animation
//so [0, 5, 13] means that the animation starts at the first frame, then 5 frames later it goes to the second frame
function PAnim_Define(_name, _frames, _sprite, _loops = false, _loop_point = 0) constructor{
	title = _name;
	frames = _frames;
	sprite_reference = _sprite;
	loops = _loops
	loop_point = _loop_point
}