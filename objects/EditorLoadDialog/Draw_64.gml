draw_set_color(c_blue);
draw_rectangle(0,0,GAME_W, 24, false);
draw_set_color(c_black);
draw_rectangle(0,24,GAME_W, GAME_H, false);
draw_string(text_input, 6, 10);
draw_string("LOAD WHICH FILE", 1, 1);
if (is_active && (current_time div 500) % 2 == 0) {
    // Draw a simple flashing typing cursor
    var _width = string_length(text_input) * 8;
	draw_set_color(c_red);
    draw_line(6 + _width, 10, 6 + _width, 18);
}

for(var w = 0; w < array_length(availible_stages); w++){
	draw_string(availible_stages[w], 2, w * 10 + 40)
}