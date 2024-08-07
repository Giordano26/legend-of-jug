function new_encounter(_enemies, _bg){
	instance_create_depth(
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]),
		-9999,
		obj_battle,
		{
			enemies : _enemies,
			creator: id,
			battle_background: _bg
		} 
		
	) 	
	
}

function skill_check(_units){
    order_grid = ds_grid_create(2,8)
    order_array = []
    for(_unit_index = 0; _unit_index < array_length(_units); _unit_index++){
        d20 = irandom_range(1, 20)
        skill_points = _units[_unit_index].spd + d20
        ds_grid_set(order_grid,0,_unit_index,_units[_unit_index])
        ds_grid_set(order_grid,1,_unit_index,skill_points)
    
    }
    
    ds_grid_sort(order_grid,1,false)
    
    for(_unit_index = 0; _unit_index < array_length(_units); _unit_index++){
        order_array[_unit_index] = ds_grid_get(order_grid,0,_unit_index)
    }
    
    
    return order_array
    
}

function battle_change_hp(_target, _amount, _alive_dead_both = 0){
	
	//alive_dead_both = item can be used on alive only = 0, dead only = 1, both = 2
	var _failed = false
	if(_alive_dead_both == 0) && (_target.hp <= 0){
		_failed = true
	}
	if(_alive_dead_both == 1) && (_target.hp > 0){
		_failed = true
	}
	
	var _color = c_white
	if(_amount > 0){
		_color = c_lime	
	}
	
	if(_failed){
		_color = c_white
		_amount = "failed"
	}
	var _vertical_adjust = SPRITE_SIZE
	
	instance_create_depth(
	_target.x, 
	_target.y - _vertical_adjust,
	_target.depth-1,
	obj_floating_text,
	{
		font: fnt_floating_text,
		color: _color,
		text: string(_amount)
		
	})
	
	if (!_failed) _target.hp = clamp(_target.hp + _amount, 0, _target.hp_max)
		
}

function battle_change_mp(_target,_amount, _alive_dead_both = 0){
	
	var _failed = false
	if(_alive_dead_both == 0) && (_target.hp <= 0){
		_failed = true
	}
	if(_alive_dead_both == 1) && (_target.hp > 0){
		_failed = true
	}
	
	var _color = c_navy
	if(_amount > 0){
		_color = c_teal	
	}
	
	if(_failed){
		_color = c_white
		_amount = "failed"
	}
	var _vertical_adjust = SPRITE_SIZE
	
	instance_create_depth(
	_target.x, 
	_target.y - _vertical_adjust,
	_target.depth-1,
	obj_floating_text,
	{
		font: fnt_floating_text,
		color: _color,
		text: string(_amount)
		
	})
	
	if (!_failed) _target.mp = clamp(_target.mp + _amount, 0, _target.mp_max)
}