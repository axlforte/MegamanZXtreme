function Player_Handle(){
	input.update();
	if(keyboard_check(vk_shift) && !input.get_pressed("shoot")) return;
	
	if(dashing != false){
		snes_physics.move_horizontal(dash_direction, 0, player_data.dashSpeed);
		
		if(dashing > dash_max_time || !snes_physics.grounded || 
		(input.get_held("right") - input.get_held("left") != 0 && input.get_held("right") - input.get_held("left") != dash_direction) || !input.get_held("dash")){
			dashing = false;
		} else {
			dashing++;
		}
	} else {
		if !walljumping{
			if(dash_jumping){
				snes_physics.move_horizontal(input.get_held("right"), input.get_held("left"), player_data.dashSpeed);
				if snes_physics.grounded dash_jumping = false;
			} else
				snes_physics.move_horizontal(input.get_held("right"), input.get_held("left"), player_data.walkSpeed);
		} else {
			walljumping++;
			if(walljumping > walljumpingMax){
				walljumping = false;
				snes_physics.hspd = 0;
			} else
				if(dash_jumping)
					snes_physics.move_horizontal(walljumpingDir, 0, player_data.dashSpeed);
				else
					snes_physics.move_horizontal(walljumpingDir, 0, player_data.walkSpeed);
					
				
		}
		
		if(input.get_pressed("dash")){
			dash_direction = snes_physics.facing_direction;
			dashing = true;
			old_positions = array_create(15, {x: snes_physics.x, y: snes_physics.y});
		}
	}
	
	if(input.get_pressed("jump") && snes_physics.grounded){
		snes_physics.vspd = player_data.jumpStrength * -1;
		snes_physics.y -= 6;
		if (dashing || input.get_held("dash")) dash_jumping = true;
	} else if(input.get_pressed("jump") && snes_physics.can_wall_jump && snes_physics.hspd != 0) {
		walljumping = true;
		snes_physics.vspd = player_data.jumpStrength * -1;
		snes_physics.y -= 6;
		snes_physics.slide_tick = false;
		
		if(snes_physics.detect_collision(x - snes_physics.width / 2, y))
			walljumpingDir = 1;
		else 
			walljumpingDir = -1;
		
		if input.get_held("dash") {
			dash_direction = snes_physics.facing_direction;
			dashing = true;
			dash_jumping = true;
			old_positions = array_create(15, {x: snes_physics.x, y: snes_physics.y});
		} else {
			dashing = false;
			dash_jumping = false;
		}
	}
	
	if(!input.get_held("jump") && snes_physics.vspd < 0){
		snes_physics.vspd = 0;
	}
	
	snes_physics.step();
	x = floor(snes_physics.x);
	y = floor(snes_physics.y);
	
	array_insert(old_positions, 0, {x: snes_physics.x, y: snes_physics.y});
	array_pop(old_positions);
	
	if walljumping snes_physics.facing_direction = walljumpingDir * -1;
	
	PAnim_Step();
	
	
}

function player_draw(){
	
	if(dashing || dash_jumping){
		PAnim_Draw(floor(old_positions[11].x), floor(old_positions[11].y), #4444bb);
		PAnim_Draw(floor(old_positions[7].x), floor(old_positions[7].y), #6666dd);
		PAnim_Draw(floor(old_positions[3].x), floor(old_positions[3].y), #8888ff);
	}
	PAnim_Draw(floor(snes_physics.x), floor(snes_physics.y));
	draw_text(0, 0, snes_physics.grounded)
	other.image_xscale = snes_physics.facing_direction;
}

function Player_Start(){
	walljumping = 0;
	walljumpingDir = 0;
	walljumpingMax = 8;
	
	dashing = false;
	dash_max_time = 30;
	dash_direction = 1;
	dash_jumping = false;
	
	old_positions = array_create(15, {x: 0, y: 0});
	
	input = new Input();
	input.init();
	snes_physics = new SPhysics(x, y);
	
	player_data = new PlayerVars();
	
	camera = instance_create_depth(0,0,0,CameraHandler);
	
	PAnim_Init();
	
	//prep the stage
	MakeLevel("strikeman_intro");
	
	//autotile time!
	Autotile();
}