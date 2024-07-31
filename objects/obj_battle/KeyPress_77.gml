menu(x + 10, y+ 10,
[	
	["Fight",-1,-1,true],
	["Magic",sub_menu,
		[[
			["Ice", -1,-1,true],
			["Back",menu_go_back,-1,true]
		]],
		true
	],
	["Escape",-1,-1,true]
]);