draw_sprite_stretched(spr_box,0,x,y,width_full,height_full)
draw_set_color(c_white)
draw_set_font(fnt_default)
draw_set_halign(fa_left)
draw_set_valign(fa_top)


var _desc = !(description == - 1)
var _scroll_push = max(0, hover - (visible_options_max - 1))

for (line = 0; line < (visible_options_max + _desc); line++){
	
	if(line >= array_length(options)){
		break
	}
	
	draw_set_color(c_white)
	if(line == 0) && (_desc){
		draw_text(x + x_margin, y + y_margin, description)
	} else {
		
		var _option_to_show = line - _desc + _scroll_push
		var _str = options[_option_to_show][0]
		
		if(hover ==  _option_to_show - _desc){
			draw_set_color(c_yellow)
		}
		
		if(options[_option_to_show][3] == false) { //unavailable option
			draw_set_color(c_gray)
		}
		
		draw_text(x + x_margin, y + y_margin + line * height_line, _str)
	
	}
}

draw_sprite(spr_pointer,0, x + x_margin + 8, y + y_margin +((hover - _scroll_push) * height_line)+7)

if(visible_options_max < array_length(options)) && (hover < array_length(options) - 1){
	
	draw_sprite(spr_down_arrow, 0,x + width_full * 0.5, y + height_full - 7)	
	
}	