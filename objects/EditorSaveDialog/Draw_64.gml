draw_set_color(c_blue);
draw_rectangle(0,0,GAME_W - 66, 24, false);
draw_string(text_input, 6, 10);
draw_string("SAVE AS", 1, 1);
if (is_active && (current_time div 500) % 2 == 0) {
    // Draw a simple flashing typing cursor
    var _width = string_length(text_input) * 8;
	draw_set_color(c_red);
    draw_line(6 + _width, 10, 6 + _width, 18);
}
