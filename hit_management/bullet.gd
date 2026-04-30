extends Area2D

@onready var collision_shape = $CollisionPolygon2D
@onready var draw_shape = $Polygon2D
@onready var vis_notif = $VisibleOnScreenNotifier2D

var radius = 10
var velocity: Vector2 = Vector2.ZERO

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
	vis_notif.rect.size.x = radius
	vis_notif.rect.size.y = radius

func _physics_process(delta: float) -> void:
	global_position+=velocity*delta

func _on_body_entered(body: Node2D) -> void:
	if(body.has_method("hit")):
		body.hit()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:

	#get_parent	().print_tree_pretty()
	#queue_free()
	pass
