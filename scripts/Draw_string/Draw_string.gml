function draw_string(_string, _x, _y){
	for(var e = 0; e < string_length(_string); e++){
		Draw_single_character(string_char_at(_string, e + 1), _x + e * 8, _y);
	}
}

function Draw_single_character(_char, _x, _y){
	if(_char == " ") return;
	
	var _num = ord(_char)
	
	if(48 <= _num && _num <= 57){
		_num -= 48;
		_num += 52;
	} else if(_num > 96){
		_num -= 97;
		_num += 26;
	} else if(_char == "." || _char == "_"){
		_num = 62;
	} else {
		_num -= 65;
	}
	
	draw_sprite(zx_font, _num, _x, _y);
}