class_name LevelTwo
extends SyncLevel

func _init(mgr: Node = null, shps: Array[Node2D] = [], mp: Node = null):
	super(mgr, shps, mp)
	level_name = "Level Two"
	difficulty = "5/5"
	length = "IDEK"
	timeline = new_timeline
	#if(new_music):
		#music = new_music


var new_timeline: Array[Dictionary] = [
	{ "t": 0.0, "a": func():
	manager.create_bullet_circle(Vector2(200,200), 200, 20, 10)
	manager.create_bullet_circle(Vector2(800,300), 200, 20, 10)
	manager.create_bullet_circle(Vector2(500,500), 200, 20, 10)
	},
	{ "t": 1.0, "a": func():
	manager.create_horizontal_wipe(0, 100, 75, Global.center.x-100, 1)
	manager.create_horizontal_wipe(Global.center.x, 100, -75, 0, 1)
	},
	{ "t": 3.0, "a": func():
	manager.create_cannon(Vector2(Global.center.x/2, 0), PI/2, 0.2, 5, 150, 10)
	},
	{ "t": 7.0, "a": func():
	manager.create_cannon(Vector2(Global.center.x/2, Global.center.y), -PI/2, 0.2, 5, 150, 10)
	},
	{ "t": 13.0, "a": func():
	shapes[0].set_verts([Vector2(-1200,-20), Vector2(-1200,20), Vector2(1200,20), Vector2(1200,-20)])
	shapes[1].set_verts([Vector2(-1200,-20), Vector2(-1200,20), Vector2(1200,20), Vector2(1200,-20)])
	shapes[0].set_scale(Vector2(0,0))
	shapes[1].set_scale(Vector2(0,0))
	shapes[0].set_position(Global.center)
	shapes[1].set_position(Global.center)
	shapes[1].set_rotation(PI/2)
	var t1 = shapes[0].create_tween()
	t1.tween_property(shapes[0], "scale", Vector2(1,1), 1).set_trans(Tween.TRANS_QUART)
	var t2 = shapes[1].create_tween()
	t2.tween_property(shapes[1], "scale", Vector2(1,1), 1).set_trans(Tween.TRANS_QUART)
	},
	{ "t": 14.0, "a": func():
	shapes[0].enable()
	shapes[1].enable()
	var t1 = shapes[0].create_tween()
	t1.tween_property(shapes[0], "rotation", 10.0, 15.0).set_trans(Tween.TRANS_LINEAR)
	var t2 = shapes[1].create_tween()
	t2.tween_property(shapes[1], "rotation", 10.0 + PI/2, 15.0).set_trans(Tween.TRANS_LINEAR)
	manager.create_horizontal_wipe(0, 50, 100, Global.screen_size.x, 1)
	manager.create_cannon(Vector2(0, Global.center.y/2), 0, 0.2, 8, 150, 10)
	manager.create_cannon(Vector2(Global.center.x, Global.center.y/2), PI, 0.2, 8, 150, 10)
	},
	{ "t": 29.0, "a": func():
	shapes[0].remove()
	shapes[1].remove()
	},
	{ "t": 31.0, "a": func():
	manager.create_horizontal_wipe(0, 10, 60, Global.center.x, 0.04, 1)
	manager.create_vertical_wipe(0, 10, 60, Global.center.y, 0.04, 1)
	},
	{ "t": 35.0, "a": func():
	shapes[0].set_verts([Vector2(-350,-20), Vector2(-350,20), Vector2(350,20), Vector2(350,-20)])
	shapes[0].set_position(Vector2(0,0))
	shapes[0].set_rotation(-PI/4)
	shapes[0].enable()
	var t1 = shapes[0].create_tween()
	t1.tween_property(shapes[0], 'position', Global.screen_size, 7).set_trans(Tween.TRANS_CUBIC)
	manager.create_cannon(Vector2(Global.center.x/2, 0), PI/2, 0.2, 5, 150, 10)
	},
	{ "t": 42.0, "a": func():
	manager.create_cannon(Vector2(Global.center.x/2, Global.center.y), -PI/2, 0.2, 5, 150, 10)
	var t1 = shapes[0].create_tween()
	t1.tween_property(shapes[0], 'position', Vector2.ZERO, 7).set_trans(Tween.TRANS_CUBIC)
	},
	{ "t": 51.0, "a": func():
	shapes[0].remove()
	var corners_and_centers = [
		#Vector2(0, 0), ector2(Global.center.x / 2, 0), Vector2(Global.center.x, 0),
		Vector2(Global.center.x, Global.center.y / 2), Vector2(Global.center.x, Global.center.y),
		Vector2(Global.center.x / 2, Global.center.y), Vector2(0, Global.center.y), Vector2(0, Global.center.y / 2)
	]
	for pos in corners_and_centers:
		var angle_to_center = pos.angle_to_point(Global.center / 2)
		manager.create_cannon(pos, angle_to_center, 0.2, 8, 150, 10)
	},
	{ "t": 63.0, "a": func():
	manager.create_horizontal_wipe(0, 10, 60, Global.center.x, 0.04, 1)
	manager.create_vertical_wipe(0, 10, 60, Global.center.y, 0.04, 1)
	var corners_and_centers = [
		Vector2(0, 0), Vector2(Global.center.x / 2, 0), Vector2(Global.center.x, 0),
		Vector2(Global.center.x, Global.center.y / 2), Vector2(Global.center.x, Global.center.y),
		Vector2(Global.center.x / 2, Global.center.y), Vector2(0, Global.center.y), Vector2(0, Global.center.y / 2)
	]
	for pos in corners_and_centers:
		var angle_to_center = pos.angle_to_point(Global.center / 2)
		manager.create_cannon(pos, angle_to_center, 0.5, 8, 120, 24)
		manager.create_cannon(pos, angle_to_center, 0.33, 4, 100, 24)
	}
]
