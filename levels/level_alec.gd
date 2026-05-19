class_name LevelAlec
extends BaseLevel

func _init(mgr: Node = null, shps: Array[Node2D] = [], mp: Node = null):
	super(mgr, shps, mp)
	music = preload("res://music/alec-singer!2.wav")
	level_name = "Alec's Level"
	difficulty = "3/5"

func play(level_node: Node):
	if music_player:
		music_player.play()
	var level = level_node.create_tween()
	level.set_parallel(true)
	level.tween_callback(manager.create_zone.bind(Vector2(100,100),Vector2(130,130))).set_delay(1.99)
	level.tween_callback(manager.create_zone.bind(Vector2(300,300),Vector2(130,130))).set_delay(2.510)
	level.tween_callback(manager.create_zone.bind(Vector2(500,100),Vector2(130,130))).set_delay(2.84)
	level.tween_callback(manager.create_horizontal_wipe.bind(0,10,60,Global.center.x,0.001,1)).set_delay(4.421)
	level.chain().tween_callback(manager.create_vertical_wipe.bind(0,10,60,Global.center.y,0.001,1))
	
	var corners_and_centers = [
		Vector2(0, 0), Vector2(Global.center.x / 2, 0), Vector2(Global.center.x, 0),
		Vector2(Global.center.x, Global.center.y / 2), Vector2(Global.center.x, Global.center.y),
		Vector2(Global.center.x / 2, Global.center.y), Vector2(0, Global.center.y), Vector2(0, Global.center.y / 2)
	]
	
	for pos in corners_and_centers:
		var angle_to_center = pos.angle_to_point(Global.center / 2)
		level.tween_callback(manager.create_cannon.bind(pos, angle_to_center, 0.5, 8, 150,10)).set_delay(3.266)
	level.tween_callback(manager.create_zone.bind(Global.center/4,Global.screen_size/4,1)).set_delay(17.97)
	level.tween_callback(manager.create_zone.bind(Global.center/4+Vector2(0,Global.center.y/2),Global.screen_size/4,1)).set_delay(18.97)
	level.tween_callback(manager.create_zone.bind((3*Global.center)/4,Global.screen_size/4,1)).set_delay(19.97)
	level.tween_callback(manager.create_zone.bind(Global.center/4+Vector2(Global.center.x/2,0),Global.screen_size/4,1)).set_delay(20.97)
