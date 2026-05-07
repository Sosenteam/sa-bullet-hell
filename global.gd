extends Node

@onready var screen_size = get_viewport().get_visible_rect().size
@onready var center = screen_size/2


var bad_color = Color(0.691, 0.0, 0.261, 1.0)
var indicator_color = Color(0.691, 0.0, 0.261, 0.25)
var invis_color = Color(0.691, 0.0, 0.261, 0)
var ui:Node

func update_health(hp,plid):
	ui.update_health(hp,plid)

func fail_player(plid):
	if(plid == 1):
		print("RED WINS")
	if(plid == 2):
		print("BLUE WINS")
