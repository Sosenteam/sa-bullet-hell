extends Area2D

@onready var collision_shape = $CollisionShape2D
@onready var draw_shape = $Polygon2D


var enabled = false:
	set(b):
		enabled = b

func _ready() -> void:
	print("zone created")
	var tween = get_tree().create_tween()
	draw_shape.color = Color(0.691, 0.0, 0.261, 0)
	tween.tween_property(draw_shape,"color",Color(0.691, 0.0, 0.261, 1.0),1)
	#tween.tween_property(,enabled,true,0)
	tween.tween_interval(1)
	#tween.tween_property($".",enabled,true,1)
	tween.tween_property(draw_shape,"color",Color(0.691, 0.0, 0.261, 0),0.1)



func move(x,y,width,height):
	position = Vector2(x,y)
	collision_shape.shape.size = Vector2(width,height)
	var verts: PackedVector2Array = []
	verts[0] = Vector2(x-width,y-height)
	verts[1] = Vector2(x+width,y-height)
	verts[2] = Vector2(x+width,y+height)
	verts[3] = Vector2(x-width,y+height)
	draw_shape.set_polygon(verts)
