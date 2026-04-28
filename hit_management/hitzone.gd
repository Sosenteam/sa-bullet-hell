extends Area2D

@onready var collision_shape = $CollisionShape2D
@onready var draw_shape = $Polygon2D

@export var default_indicator_in = 0.25
@export var default_indicator_hold = 0.25
@export var default_fade_in = 0.25
@export var default_hold = 0.1
@export var default_fade_out = 0.2

var indicator_in = default_indicator_in
var indicator_hold = default_indicator_hold
var fade_in = default_fade_in
var hold = default_hold
var fade_out = default_fade_out


var enabled = false:
	set(b):
		enabled = b

func _ready() -> void:
	var tween = get_tree().create_tween()
	draw_shape.color = Color(0.691, 0.0, 0.261, 0)
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(draw_shape,"color",Color(0.691, 0.0, 0.261, 0.25),indicator_in)
	tween.tween_interval(indicator_hold)
	tween.tween_property(draw_shape,"color",Color(0.691, 0.0, 0.261, 1.0),fade_in)
	#tween.tween_property(,enabled,true,0)
	tween.tween_interval(hold)
	#tween.tween_property($".",enabled,true,1)
	tween.tween_property(draw_shape,"color",Color(0.691, 0.0, 0.261, 0),fade_out)

	tween.tween_callback(queue_free)


func move(x,y,width,height):
	position = Vector2(x,y)
	collision_shape.shape.size = Vector2(width,height)
	var verts: PackedVector2Array = []
	verts.resize(4)
	verts[0] = Vector2(x-width,y-height)
	verts[1] = Vector2(x+width,y-height)
	verts[2] = Vector2(x+width,y+height)
	verts[3] = Vector2(x-width,y+height)
	draw_shape.set_polygon(verts)

func set_fade_time(new_fade_in,new_hold,new_fade_out):
	fade_in = new_fade_in
	hold = new_hold
	fade_out = new_fade_out
