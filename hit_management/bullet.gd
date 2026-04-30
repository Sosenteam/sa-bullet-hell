extends Area2D

@onready var collision_shape = $CollisionPolygon2D
@onready var draw_shape = $Polygon2D
@onready var vis_notif = $VisibleOnScreenNotifier2D

var radius = 10
var velocity: Vector2 = Vector2.ZERO
var on_screen = false
func _ready() -> void:
	pass

func move(pos,radius,vel):
	global_position = pos
	velocity = vel
	draw()
	
	
func draw():
	var verts: PackedVector2Array = []
	var circle_res = 16
	verts.resize(circle_res)
	for i in circle_res:
		var angle = (TAU/circle_res)*i
		verts[i] = position + radius*Vector2.from_angle(angle)
	draw_shape.set_polygon(verts)
	collision_shape.set_polygon(verts)


func _physics_process(delta: float) -> void:
	global_position+=velocity*delta
	var screen_rect = Rect2(Vector2.ZERO, get_viewport_rect().size)
	if !screen_rect.has_point(global_position):
		if(on_screen):
			print(global_position)
			queue_free()
		on_screen = false
	else:
		on_screen = true

func _on_body_entered(body: Node2D) -> void:
	if(body.has_method("hit")):
		body.hit()
