extends Area2D

func enable():
	set_collision_mask_value(1,true)

func disable():
	set_collision_mask_value(1,false)

func remove():
	queue_free()

func set_verts(verts:PackedVector2Array):
	print("hitshape verts set to ",verts)
	$Polygon2D.set_polygon(verts)
	$CollisionPolygon2D.set_polygon(verts)
