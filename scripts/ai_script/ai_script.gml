function ai_battle_actions(){
	
	var _action = actions[0] //create algorithm for choosing this 
	var _possible_targets = array_filter(obj_battle.party_units, function(_unit,_index){
		
		return(_unit.hp > 0)
	})
	
	var _target = _possible_targets[irandom(array_length(_possible_targets) - 1)]
	return [_action, _target]
	
}