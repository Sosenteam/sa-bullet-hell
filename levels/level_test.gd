class_name LevelTest
extends BaseLevel

func _init(mgr: Node = null, shps: Array[Node2D] = [], mp: Node = null):
	super(mgr, shps, mp)
	level_name = "Test Level"
	difficulty = "5/5"
	length = "IDEK"

func play(level_node: Node):
	var level = level_node.create_tween()
	level.tween_callback(manager.create_bullet_circle.bind(Vector2(200,200),200,20,10))
	level.tween_callback(manager.create_bullet_circle.bind(Vector2(800,300),200,20,10))
	level.tween_callback(manager.create_bullet_circle.bind(Vector2(500,500),200,20,10))

	level.tween_interval(1)
	level.tween_callback(manager.create_horizontal_wipe.bind(0,100,75,Global.center.x-100,1))
	level.tween_callback(manager.create_horizontal_wipe.bind(Global.center.x,100,-75,0,1))
	level.tween_interval(2)
	level.tween_callback(manager.create_cannon.bind(Vector2(Global.center.x/2,0),PI/2,0.2,5,150,10))
	level.tween_interval(4)
	level.tween_callback(manager.create_cannon.bind(Vector2(Global.center.x/2,Global.center.y),-PI/2,0.2,5,150,10))
	level.tween_interval(6)
	
	level.tween_callback(shapes[0].set_verts.bind([Vector2(-1200,-20),Vector2(-1200,20),Vector2(1200,20),Vector2(1200,-20)]))
	level.tween_callback(shapes[1].set_verts.bind([Vector2(-1200,-20),Vector2(-1200,20),Vector2(1200,20),Vector2(1200,-20)]))
	level.tween_callback(shapes[0].set_scale.bind(Vector2(0,0)))
	level.tween_callback(shapes[1].set_scale.bind(Vector2(0,0)))
	level.tween_callback(shapes[0].set_position.bind(Global.center))
	level.tween_callback(shapes[1].set_position.bind(Global.center))
	level.tween_callback(shapes[1].set_rotation.bind(PI/2))
	level.tween_property(shapes[0],"scale",Vector2(1,1),1).set_trans(Tween.TRANS_QUART)
	level.parallel().tween_property(shapes[1],"scale",Vector2(1,1),1).set_trans(Tween.TRANS_QUART)
	level.tween_callback(shapes[0].enable)
	level.tween_callback(shapes[1].enable)
	level.tween_property(shapes[0],"rotation",10,15).set_trans(Tween.TRANS_LINEAR)
	level.parallel().tween_property(shapes[1],"rotation",10+PI/2,15).set_trans(Tween.TRANS_LINEAR)
	level.parallel().tween_callback(manager.create_horizontal_wipe.bind(0,50,100,Global.screen_size.x,1))
	level.parallel().tween_callback(manager.create_cannon.bind(Vector2(0,Global.center.y/2),0,0.2,8,150,10))
	level.parallel().tween_callback(manager.create_cannon.bind(Vector2(Global.center.x,Global.center.y/2),PI,0.2,8,150,10))
	level.tween_callback(shapes[0].remove)
	level.tween_callback(shapes[1].remove)
	level.tween_interval(2)
	level.tween_callback(manager.create_horizontal_wipe.bind(0,10,60,Global.center.x,0.04,1))
	level.tween_callback(manager.create_vertical_wipe.bind(0,10,60,Global.center.y,0.04,1))
	level.tween_interval(4)
	level.tween_callback(shapes[0].set_verts.bind([Vector2(-350,-20),Vector2(-350,20),Vector2(350,20),Vector2(350,-20)]))
	level.tween_callback(shapes[0].set_position.bind(Vector2(0,0)))
	level.tween_callback(shapes[0].set_rotation.bind(-PI/4))
	level.tween_callback(shapes[0].enable)
	level.tween_property(shapes[0],'position',Global.screen_size,7).set_trans(Tween.TRANS_CUBIC)
	level.parallel().tween_callback(manager.create_cannon.bind(Vector2(Global.center.x/2,0),PI/2,0.2,5,150,10))
	level.tween_callback(manager.create_cannon.bind(Vector2(Global.center.x/2,Global.center.y),-PI/2,0.2,5,150,10))
	level.tween_property(shapes[0],'position',Vector2.ZERO,7).set_trans(Tween.TRANS_CUBIC)
	level.tween_interval(2)
	level.tween_callback(shapes[0].remove)
	
	var corners_and_centers = [
		Vector2(0, 0), Vector2(Global.center.x / 2, 0), Vector2(Global.center.x, 0),
		Vector2(Global.center.x, Global.center.y / 2), Vector2(Global.center.x, Global.center.y),
		Vector2(Global.center.x / 2, Global.center.y), Vector2(0, Global.center.y), Vector2(0, Global.center.y / 2)
	]
	
	# HELL TIME
	for pos in corners_and_centers:
		var angle_to_center = pos.angle_to_point(Global.center / 2)
		level.parallel().tween_callback(manager.create_cannon.bind(pos, angle_to_center, 0.2, 8, 150,10))
	level.tween_interval(12)
	level.tween_callback(manager.create_horizontal_wipe.bind(0,10,60,Global.center.x,0.04,1))
	level.tween_callback(manager.create_vertical_wipe.bind(0,10,60,Global.center.y,0.04,1))
	for pos in corners_and_centers:
		var angle_to_center = pos.angle_to_point(Global.center / 2)
		level.parallel().tween_callback(manager.create_cannon.bind(pos, angle_to_center, 0.5, 8, 120, 24))
		level.parallel().tween_callback(manager.create_cannon.bind(pos, angle_to_center, 0.33, 4, 100, 24))
