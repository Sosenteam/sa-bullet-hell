extends Node2D

@onready var manager = $Manager

var shapes: Array[Node2D] = [] 
@onready var corners_and_centers = [
	Vector2(0, 0),               # Top Left
	Vector2(Global.center.x / 2, 0),    # Top Center
	Vector2(Global.center.x, 0),        # Top Right
	Vector2(Global.center.x, Global.center.y / 2), # Right Center
	Vector2(Global.center.x, Global.center.y), # Bottom Right
	Vector2(Global.center.x / 2, Global.center.y), # Bottom Center
	Vector2(0, Global.center.y),        # Bottom Left
	Vector2(0, Global.center.y / 2)     # Left Center
]


func _ready() -> void:
	print("played level")
	shapes = []
	for i in 5:
		shapes.append(manager.create_shape())
	level_one()
	


func _physics_process(delta: float) -> void:
	#$HitzonePlayer.creaate_bullet(Vector2(1000,randf_range(0,600)),10,200*Vector2.from_angle(randf_range(4*PI/6,8*PI/6)))
	#$HitzonePlayer.create_bullet(Vector2(600,200),10,100*Vector2.from_angle(randf_range(4*PI/6,8*PI/6)))
	pass
	
func test_level():

	var level = get_parent().create_tween()
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

func level_one():
	var level = get_parent().create_tween()
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
