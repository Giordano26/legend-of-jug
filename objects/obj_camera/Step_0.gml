

#macro CAMERA_PAN_SPEED  23

var camera = view_get_camera(0);


var desired_horizontal = obj_player.x / 1280
desired_horizontal -= frac(desired_horizontal)
desired_horizontal *= 1280

var desired_vertical = obj_player.y / 768
desired_vertical -= frac(desired_vertical)
desired_vertical *= 768

var current_x = camera_get_view_x(camera)
var current_y = camera_get_view_y(camera)

obj_player.is_changing_room = 0

if((desired_horizontal != current_x) || (desired_vertical != current_y)){
	
	
	var dx = clamp(desired_horizontal - current_x, -CAMERA_PAN_SPEED, +CAMERA_PAN_SPEED)
	var dy = clamp(desired_vertical - current_y, -CAMERA_PAN_SPEED, +CAMERA_PAN_SPEED)
	camera_set_view_pos(camera, current_x + dx, current_y + dy)
	obj_player.is_changing_room = 1
	
}