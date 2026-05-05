extends Node


var ui:Node

func update_health(hp,plid):
	ui.update_health(hp,plid)

func fail_player(plid):
	if(plid == 1):
		print("RED WINS")
	if(plid == 2):
		print("BLUE WINS")
