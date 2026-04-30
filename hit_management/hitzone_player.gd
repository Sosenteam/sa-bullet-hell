extends AnimationPlayer

var hitzone = preload("res://hit_management/hitzone.tscn")
var bullet = preload("res://hit_management/bullet.tscn")



func create_zone(pos:Vector2,size:Vector2):
	#print("zone created at ",pos," with size ",size)
	var zone = hitzone.instantiate()
	get_tree().current_scene.add_child(zone)
	zone.move(pos.x,pos.y,size.x,size.y)

func create_bullet(pos:Vector2,radius:float,vel:Vector2):
	var bul = bullet.instantiate()
	
	get_tree().current_scene.add_child(bul)
	bul.move(pos,radius,vel)

func create_horizontal_wipe(start_x:float,size_x:float,distance_x:float,end_x:float,time_between:float):	
	var wipe_tween = get_parent().create_tween()
	var current_x = [start_x]
	wipe_tween.set_loops(floor((end_x-start_x)/distance_x))
	wipe_tween.tween_callback(
		func zone_create():
			create_zone(Vector2(current_x[0],0),Vector2(size_x,2000))
	)
	wipe_tween.tween_interval(time_between)
	#wipe_tween.tween_property(self,"current_x",1,0).as_relative()
	wipe_tween.loop_finished.connect(func(_idx):
		current_x[0] += distance_x
		#print("Updated local value: ", current_x[0])
	)

func create_vertical_wipe(start_y:float,size_y:float,distance_y:float,end_y:float,time_between:float):
	
	var wipe_tween = get_parent().create_tween()
	var current_y = [start_y]
	wipe_tween.set_loops(floor((end_y-start_y)/distance_y))
	wipe_tween.tween_callback(
		func zone_create():
			create_zone(Vector2(0,current_y[0]),Vector2(2000,size_y))
	)
	wipe_tween.tween_interval(time_between)
	#wipe_tween.tween_property(self,"current_y",1,0).as_relative()
	wipe_tween.loop_finished.connect(func(_idx):
		current_y[0] += distance_y
	)

func create_cannon(pos:Vector2,angle:float,time_between:float,lifespan:float,speed:float,bullet_size:float):
	var cannon_tween = get_parent().create_tween()
	cannon_tween.set_loops(lifespan/time_between)
	cannon_tween.tween_callback(func():
		var v = Vector2.from_angle(angle+randf_range(-PI/2.5,PI/2.5))
		create_bullet(pos,bullet_size,v*speed)
	)
	cannon_tween.tween_interval(time_between)
