enum MODE {
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2,
}

//actions library

global.action_library = {
	
	attack: {
		name: "Attack",
		description: "{0} attacks!",
		sub_menu: -1,
		target_required: true,
		target_enemy_by_default: true,
		target_all: MODE.NEVER,
		user_animation: "attack",
		effect_sprite: spr_attack_bonk, //sprite for effect on target
		effect_on_target: MODE.ALWAYS,
		func: function (_user,_targets){
			
			var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25))
			battle_change_hp(_targets[0], -_damage,0)
			
		}
	}
}


//single char data, enemies and itens... sounds a mess, maybe one file for each
global.adventurers = {
	gab:
		{
		name : "Gab",
		hp : 20,
		hp_max: 20,
		mp: 10,
		mp_max: 15,
		strength: 6,
		spd: 10,
		sprites: {idle: spr_player, attack: spr_player_attack, defend: spr_player, down: spr_player_down},
		actions: [global.action_library.attack]
	}
}

global.gub_enemies = {
	gub_minion: {
		name : "Gubinion",
		hp: 15,
		hp_max: 15,
		mp: 0,
		mp_max: 0,
		strength: 5,
		spd: 7,
		sprites: { idle: spr_gub_minion, defend: spr_gub_minion, down: spr_gub_minion},
		actions: [global.action_library.attack],
		xp_value: 15,
		ai_script : ai_battle_actions
	}
}
	
global.party = [
		
		global.adventurers.gab,
		global.adventurers.gab,
		global.adventurers.gab,
		global.adventurers.gab
		
]


