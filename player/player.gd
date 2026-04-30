extends CharacterBody2D

@onready var character_controller = $CharacterController

@export var player_id = 1 # 1 or 2
@export var player_color: Color = Color.SKY_BLUE
@export_category("Movement") 
@export var max_speed = 800
@export var acceleration_speed = 200
@export var dash_speed = 2400

func hit():
	character_controller.hit()
