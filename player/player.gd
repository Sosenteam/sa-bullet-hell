extends CharacterBody2D

@onready var character_controller = $CharacterController
@onready var trail = $Trail

@export var player_id = 1 # 1 or 2
@export var player_color: Color = Color.SKY_BLUE
@export_category("Movement") 
@export var max_speed = 800
@export var ghost_max_speed = 300
@export var current_max_speed = max_speed
@export var acceleration_speed = 200
@export var dash_speed = 2400
@export var is_ghost = false


func hit():
	character_controller.hit()
	
func be_ghost(hm):
	if hm == true:
		is_ghost = true
		current_max_speed = ghost_max_speed
		trail.current_max_segments = trail.ghost_max_segments
		modulate = Color(0.474, 0.474, 0.474, 1.0)
	else:
		is_ghost = false
		character_controller.hp = 5
		current_max_speed = max_speed
		trail.current_max_segments = trail.max_segments
		modulate = Color(1.0, 1.0, 1.0, 1.0)
		create_ripple()

func create_ripple():
	var ripple = Sprite2D.new()
	
	var gradient = Gradient.new()
	gradient.offsets = [0.0, 0.7, 1.0]
	var c = player_color
	gradient.colors = [Color(c.r, c.g, c.b, 0.0), Color(c.r, c.g, c.b, 0.8), Color(c.r, c.g, c.b, 0.0)]
	
	var tex = GradientTexture2D.new()
	tex.gradient = gradient
	tex.fill = GradientTexture2D.FILL_RADIAL
	tex.fill_from = Vector2(0.5, 0.5)
	tex.fill_to = Vector2(1.0, 0.5)
	tex.width = 256
	tex.height = 256
	
	ripple.texture = tex
	ripple.global_position = global_position
	ripple.z_index = 5
	
	get_tree().current_scene.add_child(ripple)
	
	var tween = create_tween()
	tween.set_parallel(true)
	#tween.set_trans(Tween.TRANS_OUT)
	tween.set_ease(Tween.EASE_OUT)
	
	ripple.scale = Vector2(0.2, 0.2)
	tween.tween_property(ripple, "scale", Vector2(5.0, 5.0), 0.8)
	tween.tween_property(ripple, "modulate:a", 0.0, 0.8)
	
	tween.set_parallel(false)
	tween.tween_callback(ripple.queue_free)
