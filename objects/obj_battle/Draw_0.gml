draw_sprite(battle_background,0,x,y)

//units by depth
var _unit_with_current_turn = unit_turn_order[turn].id

for(var _unit_render_index = 0; _unit_render_index < array_length(unit_render_order);_unit_render_index++){
	with (unit_render_order[_unit_render_index]){
		draw_self()
	}
}

//ui boxes calculation from % of screen
var _box_one_y_view_point = camera_get_view_height(view_camera[0]) * 0.65
var _box_one_widht = camera_get_view_height(view_camera[0]) * 0.45
var _box_one_height = camera_get_view_height(view_camera[0]) * 0.35

var _box_two_y_view_point = camera_get_view_height(view_camera[0]) * 0.65
var _box_two_x_view_point = camera_get_view_height(view_camera[0]) * 0.46
var _box_two_widht = camera_get_view_width(view_camera[0]) * 0.72
var _box_two_height = camera_get_view_height(view_camera[0]) * 0.35

//ui boxes
draw_sprite_stretched(spr_box,0,x,y+_box_one_y_view_point,_box_one_widht,_box_one_height)
draw_sprite_stretched(spr_box,0,x+_box_two_x_view_point,y+_box_two_y_view_point,_box_two_widht,_box_two_height)

//headings
draw_set_font(fnt_default)
draw_set_halign(fa_center)
draw_set_valign(fa_top)
draw_set_color(c_gray)

draw_text(x+_box_one_widht/2,y+_box_one_y_view_point+30,"INIMIGO")
draw_text(x+_box_two_x_view_point+_box_two_widht*0.1,y+_box_two_y_view_point+30, "NOME")
draw_text(x+_box_two_x_view_point+_box_two_widht*0.4,y+_box_two_y_view_point+30, "PV")
draw_text(x+_box_two_x_view_point+_box_two_widht*0.7,y+_box_two_y_view_point+30, "PM")


//enemy
draw_set_font(fnt_battle_name)
draw_set_halign(fa_center)
draw_set_valign(fa_top)
var _draw_limit = 4
var _drawn = 0

for (var _drawn_index = 0 ; (_drawn_index < array_length(enemy_units)) && (_drawn < _draw_limit); _drawn_index++){
	var _enemy = enemy_units[_drawn_index]
	
	if (_enemy.hp > 0){
		_drawn++
		draw_set_color(c_white)
		if(_enemy.id == _unit_with_current_turn) {
			draw_set_color(c_yellow)
		}
	draw_text(x+_box_one_widht/2,y+_box_one_y_view_point+60+(_drawn_index * 45),_enemy.name)
	}
}

//party info

for(var _info_index = 0; _info_index < array_length(party_units); _info_index++){
	
	draw_set_halign(fa_center)
	draw_set_color(c_white)
	var _party_member = party_units[_info_index]
	
	if(_party_member.id == _unit_with_current_turn) {
			draw_set_color(c_yellow)
		}
		
	if(_party_member.hp <= 0){
			draw_set_color(c_red)
		}
	
	draw_text(x+_box_two_x_view_point+_box_two_widht*0.1,y+_box_two_y_view_point+60+(_info_index* 45),_party_member.name)
	
	
	draw_set_color(c_white)
	if(_party_member.hp < (_party_member.hp_max * 0.5)){
			draw_set_color(c_orange)
		}
	if(_party_member.hp <= 0){
		draw_set_color(c_red)
	}
	draw_text(x+_box_two_x_view_point+_box_two_widht*0.4,y+_box_two_y_view_point+60+(_info_index* 45), string(_party_member.hp) + "/" + string(_party_member.hp_max))
	
	draw_set_color(c_white)
	if(_party_member.mp < (_party_member.mp_max * 0.5)){
			draw_set_color(c_orange)
		}
	if(_party_member.hp <= 0){
		draw_set_color(c_red)
	}
	
	draw_text(x+_box_two_x_view_point+_box_two_widht*0.7,y+_box_two_y_view_point+60+(_info_index* 45), string(_party_member.mp) + "/" + string(_party_member.mp_max))
	
	draw_set_color(c_white)
}