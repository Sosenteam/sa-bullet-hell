extends CharacterBody2D

@onready var character_controller = $CharacterController

func hit():
	character_controller.hit()
