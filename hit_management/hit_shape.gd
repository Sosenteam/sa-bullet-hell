extends Area2D

@onready var polygon = $Polygon2D
@onready var collision_polygon = $CollisionPolygon2D

func _ready() -> void:
	polygon.color = Global.indicator_color

func enable():
	set_collision_mask_value(1,true)
	polygon.color = Global.bad_color

func disable():
	set_collision_mask_value(1,false)	
	polygon.color = Global.invis_colors

func remove():
	polygon.set_polygon([])
	collision_polygon.set_polygon([])
	scale = Vector2(1,1)
	rotation = 0
	
func set_verts(verts:PackedVector2Array):
	#print("hitshape verts set to ",verts)
	polygon.set_polygon(verts)
	collision_polygon.set_polygon(verts)

func _on_body_entered(body: Node2D) -> void:
	if(body.has_method("hit")):
		body.hit()
