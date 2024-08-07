instance_deactivate_all(true)
//sets the position based on camera size and % positioning part
var _player_x_view_point = camera_get_view_width(view_camera[0]) * 0.15 
var _player_y_view_point = camera_get_view_height(view_camera[0]) * 0.35

var _enemy_x_view_point = camera_get_view_width(view_camera[0]) * 0.65
var _enemy_y_view_point = camera_get_view_height(view_camera[0]) * 0.35


units = []
unit_render_order = []
unit_turn_order = []
turn = 0

turn_count = 0
round_count = 0
battle_wait_time_frames = 60
battle_wait_time_remaining = 0
current_user = noone
current_action = -1
current_targets = noone

//make enemies

for(var _enemie_index = 0; _enemie_index < array_length(enemies); _enemie_index++) {
	//increases the distance from each unit a little bit, maybe for much enemies should create new algorithm
	enemy_units[_enemie_index] = instance_create_depth(x+_enemy_x_view_point+(_enemie_index*70), y+_enemy_y_view_point+(_enemie_index*70), depth - 10, obj_battle_unit_enemy, enemies[_enemie_index])
	array_push(units, enemy_units[_enemie_index])
	
}


//make party

for(var _party_member_index = 0; _party_member_index < array_length(global.party); _party_member_index++) {
	//increases the distance from each unit a little bit, maybe for much enemies should create new algorithm
	party_units[_party_member_index] = instance_create_depth(x+_player_x_view_point+(_party_member_index*70),y+_player_y_view_point+(_party_member_index*70), depth - 10, obj_battle_unit_pc, global.party[_party_member_index])
	array_push(units, party_units[_party_member_index])
	
}


//sets the order by the skill_check
unit_turn_order = skill_check(units)

//render order
refresh_render_order = function() {
	unit_render_order = []
	array_copy(unit_render_order,0,units,0,array_length(units))
	array_sort(unit_render_order, function(_1,_2){
		return _1.y - _2.y
	})
}

refresh_render_order()



function battle_state_select_action () {
	if (!instance_exists(obj_menu)){	
		//actual unit order
		var _unit = unit_turn_order[turn]
	
		//checks if unity is able to perfom an action
		if (!instance_exists(_unit)) || (_unit.hp <= 0 ){
		
			battle_state = battle_state_victory_check
			exit
		}
	
		//select the action if possible
		//begin_action(_unit.id,global.action_library.attack, _unit.id)
	
		if(_unit.object_index == obj_battle_unit_pc){
			//compile action menu
			var _menu_options = []
			var _sub_menus = {}
			
			var _action_list = _unit.actions
			
			for(var _action_list_index = 0; _action_list_index < array_length(_action_list); _action_list_index++){
				
				var _action = _action_list[_action_list_index]
				var _available = true
				var _name_and_count = _action.name
				if(_action.menu_name == -1){
					array_push(_menu_options, [_name_and_count, menu_select_action,[_unit,_action],_available])
				} else {
					//create or add submenu
					if(is_undefined(_sub_menus[$ _action.menu_name])){
						variable_struct_set(_sub_menus, _action.menu_name,[[_name_and_count, menu_select_action,[_unit,_action],_available]])
					
					} else {
					array_push(_sub_menus[$ _action.menu_name], [_name_and_count, menu_select_action,[_unit,_action],_available])
					}
				}
				
				var _sub_menus_array = variable_struct_get_names(_sub_menus)
				for(var _sub_menu_index = 0; _sub_menu_index < array_length(_sub_menus_array); _sub_menu_index++){
					//sort submenu if needed
					//(sort here)
					
					//add back option at the end of each submenu
					array_push(_sub_menus[$ _sub_menus_array[_sub_menu_index]], ["Voltar", menu_go_back,-1,true])
					//add submenu into main menu
					array_push(_menu_options, [_sub_menus_array[_sub_menu_index], sub_menu,[_sub_menus[$ _sub_menus_array[_sub_menu_index]]], true])
				}
				
			}
			var _menu_widht = 200
			var _menu_height = 200

			var _y_fix = camera_get_view_height(view_camera[0]) * 0.35
			var _x_fix = (camera_get_view_height(view_camera[0]) * 0.35) - _menu_widht
			menu(x +_x_fix, y + _y_fix,_menu_options,,_menu_widht,_menu_height)
			
		} else {
			var _enemy_action = _unit.ai_script()
			if(_enemy_action !=1){
				begin_action(_unit.id,_enemy_action[0],_enemy_action[1])	
			}
		}
	}
}

function begin_action(_user, _action, _targets){
	
	current_user = _user
	current_action = _action
	current_targets = _targets
	
	if(!is_array(current_targets)) {
		current_targets = [current_targets]
	}
	
	battle_wait_time_remaining = battle_wait_time_frames
	
	with(_user){
		
		acting = true
		if (!is_undefined(_action[$ "user_animation"])) && (!is_undefined(_user.sprites[$ _action.user_animation])){
			
			sprite_index = sprites[$ _action.user_animation]
			image_index = 0;
			
		}
		
		
	}
	battle_state = battle_state_perfom_action
	
}

function battle_state_perfom_action(){
	
	
	if (current_user.acting){
		
		//perform action if effect exits
		if(current_user.image_index >= current_user.image_number - 1){
			with(current_user){
				sprite_index = sprites.idle
				image_index = 0
				acting = false
			}
			
			if(variable_struct_exists(current_action, "effect_sprite")){
				
				if(current_action.effect_on_target == MODE.ALWAYS) || ( (current_action.effect_on_target == MODE.VARIES) && (array_length(current_targets) <= 1) ){
					for( var _current_target_index = 0; _current_target_index < array_length(current_targets); _current_target_index++){
							instance_create_depth(
							current_targets[_current_target_index].x,
							current_targets[_current_target_index].y - SPRITE_CENTER, 
							current_targets[_current_target_index].depth - 1, 
							obj_battle_effect,
							{sprite_index: current_action.effect_sprite} )
					}
				
				} else {
					
					var _effect_sprite = current_action.effect_sprite
					if (variable_struct_exists(current_action, "effect_sprite_no_target")){
						_effect_sprite = current_action.effect_sprite_no_target
					}
					instance_create_depth(x,y,depth-100,obj_battle_effect,{sprite_index:_effect_sprite})
					
				}
			}
			
			current_action.func(current_user, current_targets)
		}
		
	} else { 
			if(!instance_exists(obj_battle_effect)){
				battle_wait_time_remaining--
				if(battle_wait_time_remaining == 0){
					battle_state = battle_state_victory_check	
				}
			}	
	}
}

function battle_state_victory_check(){
	
	battle_state = battle_state_turn_progression
	
	
}

function battle_state_turn_progression(){
	turn_count++
	turn++
	if (turn > array_length(unit_turn_order) - 1 ){
		turn = 0
		round_count++
	}
	battle_state = battle_state_select_action
}

battle_state = battle_state_select_action