extends Area2D

@onready var collision_shape = $CollisionShape2D

func _init(x,y,width,height) -> void:
	position = Vector2(x,y)
	collision_shape.size = Vector2(width,height)
