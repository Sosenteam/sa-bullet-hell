class_name LevelOne
extends BaseLevel

func _init(mgr: Node = null, shps: Array[Node2D] = [], mp: Node = null):
	super(mgr, shps, mp)
	level_name = "Level One"
	difficulty = "1/5"
	length = "0:55"

func play(level_node: Node):
	var level = level_node.create_tween()
	for i in 8:
		var ang = remap(i,0,8,0,TAU)
		level.tween_interval(1)
		level.tween_callback(manager.create_bullet_circle.bind(Global.center/2+(250*Vector2.from_angle(ang)),400,20,10))
	for j in 20:
		var x = remap(j,0,20,0,Global.center.x)
		var x2 = remap(j,20,0,0,Global.center.x)
		level.tween_interval(0.1)
		level.tween_callback(manager.create_bullet.bind(Vector2(x,0),10,Vector2(0,200)))
		level.tween_callback(manager.create_bullet.bind(Vector2(x2+25,Global.center.y),10,Vector2(0,-200)))
	level.tween_interval(3)
	for j in 10:
		var y = remap(j,0,10,0,Global.center.y)
		var y2 = remap(j,10,0,0,Global.center.y)
		level.tween_interval(0.1)
		level.tween_callback(manager.create_bullet.bind(Vector2(0,y),10,Vector2(200,0)))
		level.tween_callback(manager.create_bullet.bind(Vector2(Global.center.x,y2+20),10,Vector2(-200,0)))
	level.tween_interval(8)
	level.tween_interval(1)
	level.set_parallel(true)
	for r in 4:
		var x_size = 120
		var y_size = 20
		var x_offset = remap(r,0,4,100,1000)
		var dir = 1
		if(r==1 or r==3):
			dir = -1
		level.tween_callback(shapes[r].set_verts.bind([Vector2(x_offset-x_size,-y_size),Vector2(x_offset+x_size,-y_size),Vector2(x_offset+x_size,y_size),Vector2(x_offset-x_size,y_size)]))
		level.tween_callback(shapes[r].set_rotation.bind(0))
		level.tween_callback(shapes[r].set_position.bind(Global.center))
		level.tween_property(shapes[r],"rotation",2*TAU*dir*(4-r),20).set_trans(Tween.TRANS_SINE).set_delay(0.5)
		level.tween_callback(shapes[r].enable).set_delay(2)
	level.chain().tween_interval(1)
	for r in 4:
		level.tween_callback(shapes[r].set_rotation.bind(0))
		level.tween_property(shapes[r],"rotation",2*TAU,6).set_trans(Tween.TRANS_SINE).set_delay(0.5)
	level.chain().tween_interval(1)
	for r in 4:
		level.tween_callback(shapes[r].remove)
	level.set_parallel(false)
	level.tween_callback(manager.create_horizontal_wipe.bind(0,10,60,Global.center.x,0.04,1))
	level.tween_callback(manager.create_vertical_wipe.bind(0,10,60,Global.center.y,0.04,1))
