extends Node

@onready var player: CharacterBody2D = $".."
@onready var rectangle: Polygon2D = $"../Rectangle"
@onready var dash_timer: Timer = $"../DashTimer"
@onready var dash_cooldown_timer: Timer = $"../DashTimer/DashCooldown"

@export var player_id = 1 # 1 or 2
@export var player_color: Color = Color.SKY_BLUE
@export_category("Movement") 
@export var max_speed = 800
@export var acceleration_speed = 200
@export var dash_speed = 2400
#
var direction : Vector2 = Vector2.ZERO
var acceleration: Vector2 = Vector2.ZERO
var is_dashing: bool = false
var dash_direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	dash_timer.timeout.connect(on_dash_end)
	rectangle.color = player_color

func _physics_process(delta: float) -> void:
	#print(dash_cooldown_timer.time_left)
	if(!is_dashing):
		player.velocity*=0.7
		acceleration = direction*acceleration_speed
		player.velocity+=acceleration
		player.velocity = player.velocity.limit_length(max_speed)
	else:
		player.velocity = dash_direction*dash_speed
	#print(player.velocity)
	rectangle.scale.y = remap(player.velocity.length(),0,dash_speed,1,0.2)
	rectangle.scale.x = remap(player.velocity.length(),0,dash_speed,1,1.8)
	if(direction != Vector2(0,0)):
		rectangle.rotation = direction.angle()
	player.move_and_slide()

func _unhandled_input(event: InputEvent) -> void:
	#print(event.as_text())
	direction = Input.get_vector(
		"player"+str(player_id)+"_left",
		"player"+str(player_id)+"_right",
		"player"+str(player_id)+"_up",
		"player"+str(player_id)+"_down"
	)
	if event.is_action_pressed("player"+str(player_id)+"_dash"):
		dash()


func dash():
	if(dash_timer.is_stopped()&&dash_cooldown_timer.is_stopped()):
		is_dashing = true
		dash_timer.start()
		dash_direction = direction
		
func on_dash_end():
	is_dashing = false
	dash_cooldown_timer.start()

func hit():
	print("HAHA YOU GOT HIT")
	var hit_tween = get_parent().create_tween()
	hit_tween.tween_property(rectangle,"color",Color.WHITE,0.25)
	hit_tween.tween_interval(0.25)
	hit_tween.tween_property(rectangle,"color",player_color,0.5)
