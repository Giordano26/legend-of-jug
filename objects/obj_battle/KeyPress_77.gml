
var _menu_widht = 200
var _menu_height = 200

var _y_fix = camera_get_view_height(view_camera[0]) * 0.35
var _x_fix = (camera_get_view_height(view_camera[0]) * 0.35) - _menu_widht

menu(x + _x_fix, y + _y_fix,
[	
	["Fight",-1,-1,true],
	["Magic",sub_menu,
		[[
			["Ice", -1,-1,true],
			["Back",menu_go_back,-1,true]
		]],
		true
	],
	["Escape",-1,-1,true],
	["Escape",-1,-1,true],
	["Escape",-1,-1,true],
],,_menu_widht,_menu_height);