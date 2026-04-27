extends AnimationPlayer

var hitzone = preload("res://hit_management/hitzone.tscn")


func create_zone(pos:Vector2,size:Vector2):
	print("create_zone() called")
	var zone = hitzone.instantiate()
	add_child(zone)
	zone.move(pos.x,pos.y,size.x,size.y)
