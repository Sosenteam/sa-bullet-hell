extends Node2D

func _ready() -> void:
	print("played test")
	$HitzonePlayer.play("test")


func _physics_process(delta: float) -> void:
	#$HitzonePlayer.create_bullet(Vector2(1000,randf_range(0,600)),10,200*Vector2.from_angle(randf_range(4*PI/6,8*PI/6)))
	#$HitzonePlayer.create_bullet(Vector2(600,200),10,100*Vector2.from_angle(randf_range(4*PI/6,8*PI/6)))
	pass
