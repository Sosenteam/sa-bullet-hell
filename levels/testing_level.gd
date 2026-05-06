extends Node2D

@onready var manager = $Manager

func _ready() -> void:
	print("played test")
	play()
	


func _physics_process(delta: float) -> void:
	#$HitzonePlayer.creaate_bullet(Vector2(1000,randf_range(0,600)),10,200*Vector2.from_angle(randf_range(4*PI/6,8*PI/6)))
	#$HitzonePlayer.create_bullet(Vector2(600,200),10,100*Vector2.from_angle(randf_range(4*PI/6,8*PI/6)))
	pass
	
func play():
	var level = get_parent().create_tween()
	level.tween_interval(1)
	#level.tween_callback(manager.create_horizontal_wipe.bind(50,100,75,800,1))
	#level.tween_interval(2)
	#level.tween_callback(manager.create_cannon.bind(Vector2(200,-30),PI/2,0.2,5,100,5))
	#level.tween_callback(manager.create_horizontal_wipe.bind(800,100,-75,50,1))
	#level.tween_interval(8)
	#level.tween_callback(manager.create_vertical_wipe.bind(0,30,30,800,0.5))
	var shape_test = [null]
	level.tween_callback(func():
		print("creating shape")
		shape_test[0] = manager.create_shape()
		print(shape_test[0])
	)
	level.tween_interval(3)
	level.tween_callback(func():
		print(shape_test[0])
		shape_test[0].set_verts([Vector2(0,0),Vector2(100,10),Vector2(10,200)])
	)
	level.tween_interval(5)
