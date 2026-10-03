is_active = true;
text_input = "";

keyboard_string = "";

availible_stages = [];

var _search_pattern = working_directory + "stages/*.*"; 

var _file_name = file_find_first(_search_pattern, 0);

while(_file_name != ""){
	array_push(availible_stages, string_split(_file_name, FILE_EXTENSION)[0]);
    _file_name = file_find_next();
}

log(availible_stages)