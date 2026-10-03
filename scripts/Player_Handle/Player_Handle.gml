function Player_Handle(){
	input.update();
	if(keyboard_check(vk_shift) && !input.get_pressed("shoot")) return;
	
	if(invuln_time > 0 && invuln_time < 16){
		snes_physics.move_horizontal(0, dash_direction, 0.75);
		invuln_time++;
		snes_physics.step()
		snes_physics.facing_direction = dash_direction;
		x = floor(snes_physics.x);
		y = floor(snes_physics.y);
		PAnim_Step();
		return;
	} else if(invuln_time > 0){
		invuln_time++;
		if(invuln_max < invuln_time)
			invuln_time = 0;
	} else if(instance_place(x, y, Hurtbox)){
		invuln_time = true;
		dash_direction = snes_physics.facing_direction;
		snes_physics.vspd = -2;
		dash_jumping = false;
		player_data.hp -= instance_place(x, y, Hurtbox).damage;
		
		if(player_data.hp <= 0){
			room_restart();
		}
		return;
	}
	
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
	
	if(instance_exists(EditObject) && keyboard_check_pressed(vk_escape)){
		with(EditObject){
			state = "collision"
			x = other.camera.x - GAME_W / 2
			y = other.camera.y - GAME_H / 2
			player_test_start_x = other.x;
			player_test_start_y = other.y;
		}
		instance_destroy(camera)
		instance_destroy(self)
	}
}

function player_draw(){
	
	
	if(dashing || dash_jumping){
		PAnim_Draw(floor(old_positions[11].x), floor(old_positions[11].y), #4444bb);
		PAnim_Draw(floor(old_positions[7].x), floor(old_positions[7].y), #6666dd);
		PAnim_Draw(floor(old_positions[3].x), floor(old_positions[3].y), #8888ff);
	}
	if(invuln_time mod 2 == 0)
	PAnim_Draw(floor(snes_physics.x), floor(snes_physics.y));
	draw_text(0, 0, snes_physics.grounded)
	other.image_xscale = snes_physics.facing_direction;
}

function player_draw_gui(){
	draw_set_color(#cbdbfc)
	draw_rectangle(0,0,GAME_W, 15, false)
	draw_set_color(#306082)
	draw_rectangle(0,15,GAME_W, 15, false)
	draw_set_color(#222034)
	draw_rectangle(112,0,113, 15, false)
	
	for(var e = 0; e < player_data.max_hp; e++){
		if(e > player_data.hp - 1)
			draw_sprite(zx_hud_health_empty, 0, 15 + e * 3, 0)
		else if(e mod 3 == 2)
			draw_sprite(zx_hud_health_notch, 0, 15 + e * 3, 0)
		else
			draw_sprite(zx_hud_health_nugget, 0, 15 + e * 3, 0)
	}
	draw_sprite(zx_hud_health_cap, 0, 13, 0);
	for(var e = 0; e < 30; e++){
		if(e mod 3 == 2)
			draw_sprite_ext(zx_hud_health_notch_evil, 0, 15 + e * 3, 15, 1, -1, 0, c_white, 1)
		else
			draw_sprite_ext(zx_hud_health_nugget_evil, 0, 15 + e * 3, 15, 1, -1, 0, c_white, 1)
	}
	draw_sprite_ext(zx_hud_health_cap, 0, 13, 15, 1, -1, 0, c_white, 1);
	
	draw_string(player_data.hp, 0, 0)
}

function Player_Start(){
	walljumping = 0;
	walljumpingDir = 0;
	walljumpingMax = 8;
	
	dashing = false;
	dash_max_time = 30;
	dash_direction = 1;
	dash_jumping = false;
	
	invuln_time = 0;
	invuln_max = 90;
	
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