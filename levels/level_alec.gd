class_name LevelOne
extends SyncLevel

func _init(mgr: Node = null, shps: Array[Node2D] = [], mp: Node = null):
	super(mgr, shps, mp)
	level_name = "Level One"
	difficulty = "5/5"
	length = "IDEK"
	timeline = get_timeline()
	#if(new_music):
		#music = new_music


func get_timeline() -> Array[Dictionary]:
	var timeline: Array[Dictionary] = []
	var time: float = 0.0

	# --- PHASE 1: Bullet Circles ---
	for i in 8:
		time += 1.0
		var ang = remap(i, 0, 8, 0, TAU)
		var spawn_pos = Global.center / 2 + (250 * Vector2.from_angle(ang))
		timeline.append({
			"t": time,
			"a": func(): manager.create_bullet_circle(spawn_pos, 400, 20, 10)
		})

	# --- PHASE 2: Horizontal Curtain (X) ---
	for j in 20:
		time += 0.1
		var x = remap(j, 0, 20, 0, Global.center.x)
		var x2 = remap(j, 20, 0, 0, Global.center.x)
		timeline.append({
			"t": time,
			"a": func():
				manager.create_bullet(Vector2(x, 0), 10, Vector2(0, 200))
				manager.create_bullet(Vector2(x2 + 25, Global.center.y), 10, Vector2(0, -200))
		})

	time += 3.0

	# --- PHASE 3: Vertical Curtain (Y) ---
	for j in 10:
		time += 0.1
		var y = remap(j, 0, 10, 0, Global.center.y)
		var y2 = remap(j, 10, 0, 0, Global.center.y)
		timeline.append({
			"t": time,
			"a": func():
				manager.create_bullet(Vector2(0, y), 10, Vector2(200, 0))
				manager.create_bullet(Vector2(Global.center.x, y2 + 20), 10, Vector2(-200, 0))
		})

	time += 8.0
	time += 1.0

	# --- PHASE 4: Rotating Shapes (Parallel Simulation) ---
	# Shape Initialization
	var init_time = time
	timeline.append({
		"t": init_time,
		"a": func():
			for r in 4:
				var x_size = 120
				var y_size = 20
				var x_offset = remap(r, 0, 4, 100, 1000)
				shapes[r].set_verts([Vector2(x_offset - x_size, -y_size), Vector2(x_offset + x_size, -y_size), Vector2(x_offset + x_size, y_size), Vector2(x_offset - x_size, y_size)])
				shapes[r].set_rotation(0)
				shapes[r].set_position(Global.center)
	})

	# Shape Rotations (Trans Sine over 20 seconds, starts 0.5s late)
	# Shape Enables (Starts 2.0s late)
	timeline.append({
		"t": init_time + 0.5,
		"a": func():
			var tween = manager.create_tween().set_parallel(true)
			for r in 4:
				var dir = -1 if (r == 1 or r == 3) else 1
				tween.tween_property(shapes[r], "rotation", 2 * TAU * dir * (4 - r), 20).set_trans(Tween.TRANS_SINE)
	})
	
	timeline.append({
		"t": init_time + 2.0,
		"a": func():
			for r in 4: shapes[r].enable()
	})

	# --- PHASE 5: Shape Reset and Fast Spin ---
	# Total time elapsed for previous block: 20 seconds of rotation + 0.5s delay
	time += 20.5 
	time += 1.0 # chain().tween_interval(1)
	
	var spin_time = time
	timeline.append({
		"t": spin_time,
		"a": func():
			for r in 4: shapes[r].set_rotation(0)
	})
	
	timeline.append({
		"t": spin_time + 0.5,
		"a": func():
			var tween = manager.create_tween().set_parallel(true)
			for r in 4:
				tween.tween_property(shapes[r], "rotation", 2 * TAU, 6).set_trans(Tween.TRANS_SINE)
	})

	# --- PHASE 6: Shape Removal and Grid Wipes ---
	# Total time elapsed for previous block: 6 seconds of rotation + 0.5s delay
	time += 6.5
	time += 1.0 # chain().tween_interval(1)

	timeline.append({
		"t": time,
		"a": func():
			for r in 4: shapes[r].remove()
			manager.create_horizontal_wipe(0, 10, 60, Global.center.x, 0.04, 1)
			manager.create_vertical_wipe(0, 10, 60, Global.center.y, 0.04, 1)
	})

	return timeline
