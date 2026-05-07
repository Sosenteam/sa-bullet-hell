extends Node2D

@onready var manager = $Manager

var shapes: Array[Node2D] = [] 

func _ready() -> void:
	print("played test")
	play()
	


func _physics_process(delta: float) -> void:
	#$HitzonePlayer.creaate_bullet(Vector2(1000,randf_range(0,600)),10,200*Vector2.from_angle(randf_range(4*PI/6,8*PI/6)))
	#$HitzonePlayer.create_bullet(Vector2(600,200),10,100*Vector2.from_angle(randf_range(4*PI/6,8*PI/6)))
	pass
	
func play():
	shapes = []
	for i in 5:
		shapes.append(manager.create_shape())
	
	var level = get_parent().create_tween()
	level.tween_interval(1)
	level.tween_callback(manager.create_horizontal_wipe.bind(0,100,75,Global.center.x-100,1))
	level.tween_callback(manager.create_horizontal_wipe.bind(Global.center.x,100,-75,0,1))
	level.tween_interval(2)
	level.tween_callback(manager.create_cannon.bind(Vector2(Global.center.x/2,0),PI/2,0.2,5,150,5))
	level.tween_interval(4)
	level.tween_callback(manager.create_cannon.bind(Vector2(Global.center.x/2,Global.center.y),-PI/2,0.2,5,150,5))
	level.tween_interval(6)
#
	#
	level.tween_callback(shapes[0].set_verts.bind([Vector2(-1200,-20),Vector2(-1200,20),Vector2(1200,20),Vector2(1200,-20)]))
	level.tween_callback(shapes[1].set_verts.bind([Vector2(-1200,-20),Vector2(-1200,20),Vector2(1200,20),Vector2(1200,-20)]))
	level.tween_callback(shapes[0].set_scale.bind(Vector2(0,0)))
	level.tween_callback(shapes[1].set_scale.bind(Vector2(0,0)))
	level.tween_callback(shapes[0].set_position.bind(Global.center))
	level.tween_callback(shapes[1].set_position.bind(Global.center))
	level.tween_callback(shapes[1].set_rotation.bind(PI/2))
	level.tween_property(shapes[0],"scale",Vector2(1,1),1).set_trans(Tween.TRANS_QUART)
	level.parallel().tween_property(shapes[1],"scale",Vector2(1,1),1).set_trans(Tween.TRANS_QUART)
	level.parallel().tween_property(shapes[1],"scale",Vector2(1,1),1).set_trans(Tween.TRANS_QUART)
	level.tween_callback(shapes[0].enable)
	level.tween_callback(shapes[1].enable)
	level.tween_property(shapes[0],"rotation",10,15).set_trans(Tween.TRANS_LINEAR)
	level.parallel().tween_property(shapes[1],"rotation",10+PI/2,15).set_trans(Tween.TRANS_LINEAR)
	level.parallel().tween_callback(manager.create_horizontal_wipe.bind(0,50,100,Global.screen_size.x,1))
	level.parallel().tween_callback(manager.create_cannon.bind(Vector2(0,Global.center.y/2),0,0.2,8,150,5))
	level.parallel().tween_callback(manager.create_cannon.bind(Vector2(Global.center.x,Global.center.y/2),PI,0.2,8,150,5))
	level.tween_callback(shapes[0].remove)
	level.tween_callback(shapes[1].remove)
	level.tween_interval(2)
	level.tween_callback(manager.create_horizontal_wipe.bind(0,10,60,Global.center.x,0.04,1))
	level.tween_callback(manager.create_vertical_wipe.bind(0,10,60,Global.center.y,0.04,1))
	level.tween_interval(4)
	level.tween_callback(shapes[0].set_verts.bind([Vector2(-1200,-20),Vector2(-1200,20),Vector2(1200,20),Vector2(1200,-20)]))
	level.tween_callback(shapes[1].set_verts.bind([Vector2(-1200,-20),Vector2(-1200,20),Vector2(1200,20),Vector2(1200,-20)]))
