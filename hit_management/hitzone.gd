extends Area2D

@onready var collision_shape = $CollisionPolygon2D
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


var enabled = false

func _ready() -> void:
	var tween = get_tree().create_tween()
	draw_shape.color = Global.invis_color
	tween.set_trans(Tween.TRANS_EXPO)
	tween.set_ease(Tween.EASE_IN)
	tween.tween_property(draw_shape,"color",Global.indicator_color,indicator_in)
	tween.tween_interval(indicator_hold)
	tween.tween_property(draw_shape,"color",Global.bad_color,fade_in)
	tween.tween_callback(
		func enable_hitbox():
			enabled = true
			set_collision_mask_value(1,true)
	)
	tween.tween_interval(hold)
	tween.tween_callback(
		func disable_hitbox():
			enabled = false
			set_collision_mask_value(1,false)

	)
	tween.tween_property(draw_shape,"color",Global.invis_color,fade_out)

	tween.tween_callback(queue_free)


func move(x,y,width,height):
	position = Vector2(x,y)
	var verts: PackedVector2Array = []
	verts.resize(4)
	verts[0] = Vector2(x-width,y-height)
	verts[1] = Vector2(x+width,y-height)
	verts[2] = Vector2(x+width,y+height)
	verts[3] = Vector2(x-width,y+height)
	draw_shape.set_polygon(verts)
	collision_shape.set_polygon(verts)

func set_fade_time(new_fade_in,new_hold,new_fade_out):
	fade_in = new_fade_in
	hold = new_hold
	fade_out = new_fade_out



func _on_body_entered(body: Node2D) -> void:
	if(body.has_method("hit")):
		body.hit()
