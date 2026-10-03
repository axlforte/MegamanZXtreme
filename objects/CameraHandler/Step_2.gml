x = instance_nearest(x,y,player).x;
y = instance_nearest(x,y,player).y;

x = clamp(x, GAME_W / 2, (global.room_width * 16) - GAME_W / 2);
y = clamp(y, GAME_H / 2, (global.room_height * 16) - GAME_H / 2);

camera_set_view_pos(view_get_camera(view_current), x - GAME_W / 2, y - GAME_H / 2);