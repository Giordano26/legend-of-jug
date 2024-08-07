

function menu(_x,_y,_options,_description = -1,_width = undefined,_height = undefined){
	//maybe should change from array to a struct later
	
	with( instance_create_depth(_x,_y,-99999, obj_menu)){
		
		options = _options
		description = _description
		var _options_count = array_length(_options)
		visible_options_max = _options_count
	
		//set up size
		x_margin = 30
		y_margin = 30
		draw_set_font(fnt_default)
		height_line = 30
		
		//auto width
		if (_width == undefined){
			
			widht = 1
			if (description != -1){
				widht = max(widht, string_width(_description))
			}
			for (var _options_index = 0; _options_index < _options_count; _options_index++){
				
				widht = max(widht, string_width(_options[_options_index][0]))
				
			}
			width_full = widht + x_margin * 2
				
		} else {
			
			width_full = _width
		}
		
		if(_height == undefined) {
			
			height = height_line * (_options_count + !(description == -1 ))
			height_full = height * y_margin * 2
			
		} else {
			
			height_full = _height
			
			if (height_line * (_options_count + !(description == -1 )) > _height - (y_margin*2)) {
				
				scrolling = true
				visible_options_max = (_height - y_margin * 2) div height_line
			
			}
		
		}
	}
}


function sub_menu(_options){

	options_above[sub_menu_level] = options
	sub_menu_level++
	options = _options
	hover = 0
	
}


function menu_go_back(){
	
	sub_menu_level--
	options = options_above[sub_menu_level]
	hover = 0
}


function menu_select_action(_user, _action){
	
	with(obj_menu) active = false
	
	with(obj_battle) begin_action(_user,_action,_user)
	
	with(obj_menu) instance_destroy()
	
}