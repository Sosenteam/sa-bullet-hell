extends Control

@onready var blue_health = $"Bars/BlueHealth"
@onready var red_health = $"Bars/RedHealth"

func _ready() -> void:
	Global.ui = self

func update_health(hp,player_id):
	if(player_id == 1):
		blue_health.value = hp
	elif(player_id == 2):
		red_health.value = hp
