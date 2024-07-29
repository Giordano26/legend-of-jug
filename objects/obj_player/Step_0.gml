var _left_key = keyboard_check(ord("A"))
var _right_key = keyboard_check(ord("D"))
var _up_key = keyboard_check(ord("W"))
var _down_key = keyboard_check(ord("S"))

// movement happens whenever is not trasitioning 
if is_changing_room == 0 {
	 move_horizontal =  _right_key -_left_key 
	 move_vertical =  _down_key - _up_key 

	horizontal_speed = move_horizontal * acceleration
	vertical_speed = move_vertical * acceleration

	//correction for diagonal movement

	if (horizontal_speed != 0 && vertical_speed != 0){
		
		horizontal_speed = move_horizontal * diagonal_acceleration
		vertical_speed = move_vertical * diagonal_acceleration
	
}

} else {
		horizontal_speed =  move_horizontal * (acceleration / 2)
		vertical_speed = move_vertical * (acceleration / 2)
}



//horizontal collision
if place_meeting(x+horizontal_speed,y, obj_wall){
	
	while !place_meeting(x+sign(horizontal_speed),y, obj_wall){
		x+=sign(horizontal_speed)
	}
	
	horizontal_speed = 0
}

x+= horizontal_speed




//vertical collision
if place_meeting(x,y+vertical_speed, obj_wall){
	
	while !place_meeting(x,y+sign(vertical_speed), obj_wall){
		y+=sign(vertical_speed)
	}
	
	vertical_speed = 0
}

y+= vertical_speed
