class_name LevelThree extends SyncLevel

func _init(mgr: Node = null, shps: Array[Node2D] = [], mp: Node = null):
	super(mgr, shps, mp)
	level_name = "Anti-Camping Protocol"
	difficulty = "5/5"
	length = "2:00"
	timeline = get_timeline()

func get_timeline() -> Array[Dictionary]:
	var timeline: Array[Dictionary] = []
	var time: float = 0.0

	# --- PHASE 1: Corner-Flushing Barrage & Homing Triangles (0:00 - 0:30) ---
	# Target the edges immediately so the player cannot camp the boundaries
	for i in 150:
		time += 0.08
		var step = remap(i % 20, 0, 20, 0, Global.center.x * 2)
		timeline.append({
			"t": time,
			"a": func():
				# Corner / Perimeter sweeping bullets to push player into the inner ring
				manager.create_bullet(Vector2(step, -10), 12, Vector2(0, 500))
				manager.create_bullet(Vector2(-10, step), 12, Vector2(500, 0))
				manager.create_bullet(Vector2(step, Global.center.y * 2 + 10), 12, Vector2(0, -500))
				manager.create_bullet(Vector2(Global.center.x * 2 + 10, step), 12, Vector2(-500, 0))
		})

	# SHAPE EVENT 1: Sharp tracking triangles that chase the player's general quadrants
	var p1_shapes = 0.0
	timeline.append({
		"t": p1_shapes,
		"a": func():
			var tween = manager.create_tween().set_parallel(true).set_loops()
			for r in 4:
				# Smaller, highly compact triangle wedges (easy to dodge if moving, impossible if standing still)
				var size = 60
				var verts = [Vector2(0, -size), Vector2(size * 0.7, size * 0.7), Vector2(-size * 0.7, size * 0.7)]
				shapes[r].set_verts(verts)
				shapes[r].set_position(Global.center + Vector2.from_angle(remap(r, 0, 4, 0, TAU)) * 400)
				shapes[r].scale = Vector2.ZERO
				
				# Action: Scale in fast, then lock into a shifting quad-chase path
				tween.tween_property(shapes[r], "scale", Vector2.ONE, 0.4).set_trans(Tween.TRANS_BACK)
				tween.tween_property(shapes[r], "rotation", -TAU * 3, 2.5).as_relative()
				
				# Dynamic pathing: Shapes constantly trade corners across the screen center
				var next_angle = remap(r, 0, 4, 0, TAU) + PI/2
				var target_pos = Global.center + Vector2.from_angle(next_angle) * (200 + (r * 30))
				tween.tween_property(shapes[r], "position", target_pos, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	})
	
	timeline.append({
		"t": p1_shapes + 0.4,
		"a": func():
			for r in 4: shapes[r].enable()
	})

	# --- PHASE 2: The Pinwheel Blender (0:30 - 1:10) ---
	# Reconfigure rectangles into a central sweeping hazard with explicit gap channels
	var p2_time = time
	timeline.append({
		"t": p2_time,
		"a": func():
			var tween = manager.create_tween().set_parallel(true).set_loops()
			for r in 4:
				# Shortened length + increased thickness ensures they block sections without trapping the player against walls
				var w = 160 
				var h = 35
				var verts = [Vector2(-w, -h), Vector2(w, -h), Vector2(w, h), Vector2(-w, h)]
				shapes[r].set_verts(verts)
				
				# Anchor them around the center region in a cross configuration
				shapes[r].set_position(Global.center)
				shapes[r].set_rotation(remap(r, 0, 4, 0, TAU))
				
				# The blender effect: Continuous acceleration/deceleration rotation loops
				var dir = 1 if r % 2 == 0 else -1
				var seq = manager.create_tween().set_loops()
				seq.tween_property(shapes[r], "rotation", TAU * dir, 2.0).as_relative().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
				seq.tween_property(shapes[r], "rotation", TAU * dir, 4.0).as_relative().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
				
				# Pulsate the size slightly so safe zones fluctuate
				tween.tween_property(shapes[r], "scale", Vector2(1.3, 1.3), 1.5).set_trans(Tween.TRANS_SINE)
				tween.tween_property(shapes[r], "scale", Vector2(0.8, 0.8), 1.5).set_delay(1.5).set_trans(Tween.TRANS_SINE)
	})

	# Alternating spiral waves fired strictly from border zones to force micro-movements
	for j in 180:
		time += 0.06
		var angle = remap(j, 0, 180, 0, TAU * 6)
		# Spawn outside bounds, sweep completely across the center blender area
		var border_spawn = Global.center + Vector2.from_angle(angle) * 500
		var target_vec = (Global.center - border_spawn).normalized() * 550
		timeline.append({
			"t": time,
			"a": func():
				manager.create_bullet(border_spawn, 15, target_vec)
		})

	# --- PHASE 3: The Perimeter Grind Vortex (1:10 - 1:40) ---
	# Move shapes out to patrol the corners directly, turning the edges into a buzzsaw
	var p3_time = time
	timeline.append({
		"t": p3_time,
		"a": func():
			var tween = manager.create_tween().set_parallel(true).set_loops()
			for r in 4:
				# Diamond spikes
				var size = 50
				var verts = [Vector2(0, -size), Vector2(size, 0), Vector2(0, size), Vector2(-size, 0)]
				shapes[r].set_verts(verts)
				
				# Set shapes to circle the perimeter boundaries endlessly
				var angle_offset = remap(r, 0, 4, 0, TAU)
				var path_seq = manager.create_tween().set_loops()
				for step in 4:
					var current_angle = angle_offset + (step * (PI / 2))
					var corner_target = Global.center + Vector2.from_angle(current_angle) * 380
					path_seq.tween_property(shapes[r], "position", corner_target, 1.2).set_trans(Tween.TRANS_SINE)
				
				tween.tween_property(shapes[r], "rotation", -TAU * 4, 2.0).as_relative()
	})

	# While shapes occupy corners, standard crossfire targets the middle lanes
	for k in 120:
		time += 0.08
		var shift = remap(k % 10, 0, 10, 150, Global.center.x * 2 - 150)
		timeline.append({
			"t": time,
			"a": func():
				# Linear lane sweeps that force the player to weave between the edge-patrolling shapes
				if k % 2 == 0:
					manager.create_bullet(Vector2(shift, -15), 13, Vector2(0, 480))
				else:
					manager.create_bullet(Vector2(-15, shift), 13, Vector2(480, 0))
		})

	# --- PHASE 4: The Ultimate Displacer & Wipeout (1:40 - 2:00) ---
	# Shapes cluster together to build a compact revolving central hub
	var p4_time = time
	timeline.append({
		"t": p4_time,
		"a": func():
			var tween = manager.create_tween().set_parallel(true)
			for r in 4:
				var size = 70
				var verts = [Vector2(-size, -size), Vector2(size, -size), Vector2(size, size), Vector2(-size, size)]
				shapes[r].set_verts(verts)
				
				# Animate a fast transition from corners straight into a spinning center core
				var offset_pos = Global.center + Vector2.from_angle(remap(r, 0, 4, 0, TAU)) * 90
				tween.tween_property(shapes[r], "position", offset_pos, 0.8).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
				tween.tween_property(shapes[r], "rotation", TAU * 5, 8.0).as_relative()
	})

	# Screen-flushing perimeter laser grid to close out the layout
	for m in 60:
		time += 0.07
		var wipe_pos = remap(m % 12, 0, 12, 40, Global.center.y * 2 - 40)
		timeline.append({
			"t": time,
			"a": func():
				manager.create_bullet(Vector2(-20, wipe_pos), 16, Vector2(600, 0))
				manager.create_bullet(Vector2(Global.center.x * 2 + 20, wipe_pos), 16, Vector2(-600, 0))
		})

	# Final clear sequence
	time += 1.0
	timeline.append({
		"t": time,
		"a": func():
			var scale_tween = manager.create_tween().set_parallel(true)
			for r in 4:
				scale_tween.tween_property(shapes[r], "scale", Vector2.ZERO, 0.3).set_trans(Tween.TRANS_SINE)
	})
	
	timeline.append({
		"t": time + 0.3,
		"a": func():
			for r in 4: shapes[r].remove()
			manager.create_horizontal_wipe(0, 30, 99, Global.center.x, 0.01, 1)
			manager.create_vertical_wipe(0, 30, 99, Global.center.y, 0.01, 1)
	})

	return timeline
