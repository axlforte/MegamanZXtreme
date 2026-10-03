
function SPhysics(_x, _y) constructor{
	
	y = _y;
	x = _x;
	
	width = 12; 
	height = 24;
	
	slide_tick = false;
	
	hspd = 0;
	vspd = 0;
	grav = 0.25;
	grounded = false;
	can_wall_jump = false;
	
	facing_direction = 1;
	
	step = function(_autohold){
		if(hspd != 0) {
			facing_direction = sign(hspd);
		}
		
		x += hspd;
		//knee check
		if(detect_collision(x + width / 2, y - 7)){
			while(detect_collision(x + width / 2 - 1, y - 7)){
				x--;
			}
			can_wall_jump = true;
		} else if(detect_collision(x - width / 2, y - 7)){
			while(detect_collision(x - width / 2 + 1, y - 7)){
				x++;
			}
			can_wall_jump = true;
		} else if(detect_collision(x + width / 2, y - 12)){
			while(detect_collision(x + width / 2 - 1, y - 12)){
				x--;
			}
			can_wall_jump = true;
		} else if(detect_collision(x - width / 2, y - 12)){
			while(detect_collision(x - width / 2 + 1, y - 12)){
				x++;
			}
			can_wall_jump = true;
		} else if(detect_collision(x + width / 2, y - 18)){
			while(detect_collision(x + width / 2 - 1, y - 18)){
				x--;
			}
			can_wall_jump = true;
		} else if(detect_collision(x - width / 2, y - 18)){
			while(detect_collision(x - width / 2 + 1, y - 18)){
				x++;
			}
			can_wall_jump = true;
		} else can_wall_jump = false;
		
		if(can_wall_jump && vspd <= 0)
			can_wall_jump = false;
			
		
		if(detect_collision(x, y - height)){
			while(detect_collision(x, y - height + 1)){
				y++;
			}
			vspd = grav;
		}
		
		if(!detect_collision(x, y + 5)){
			y += vspd;
			grounded = false;
			while(detect_collision(x, y - 1)){
				y--;
				grounded = true;
			}
		} else {
			y += 8;
			while(detect_collision(x, y - 1)){
				y--;
			}
			grounded = true;
		}
			
		gravity_loop();
		
		x = max(x, 4);
		y = max(y, 16);
	}
	
	gravity_loop = function(){
		if(!detect_collision(x, y)){
			if (can_wall_jump && hspd != 0 && vspd >= 0){
				
				vspd = 1;
			} else
				vspd = clamp(vspd + grav, -10000, 6);
		} else {
			vspd = 0;
		}
	}
	
	move_horizontal = function(right_amount, left_amount, magnitude){
		hspd = (right_amount - left_amount) * magnitude;
	}
	
	detect_collision = function(px, py){
		return position_meeting(floor(px), floor(py), Collision);
	}
}