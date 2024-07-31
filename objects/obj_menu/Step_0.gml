
if (active){
	var _up_key = keyboard_check_pressed(ord("W"))
	var _down_key = keyboard_check_pressed(ord("S"))
	
	//control for menu
	hover += _down_key - _up_key
	
	if(hover > array_length(options) - 1) {
		hover = 0
	}
	
	if(hover < 0) {
		hover = array_length(options) - 1
	}
	
	//exec selected option
	
	if(keyboard_check_pressed(vk_enter)){
		
		if(array_length(options[hover]) > 1) && (options[hover][3] == true){ //checking available flag
		
			if(options[hover][1] != -1){ //checking if option has a func
				
				var _func = options[hover][1]
				if(options[hover][2] != -1){ //checking arguments for func
					script_execute_ext(_func,options[hover][2])
				} else {
					_func() //executes func anyway, without arguments
				}
			
			}
		
		}
		
	}
}
	
	
	if(keyboard_check_pressed(ord("X"))){
		
		if(sub_menu_level > 0){
			menu_go_back()
	}
	
}