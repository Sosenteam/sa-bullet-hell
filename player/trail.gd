extends Line2D

@onready var player = $".."
@export var max_segments = 6
@export var ghost_max_segments = 20
@export var current_max_segments = max_segments


func _ready() -> void:
	set_as_top_level(true)
	points.resize(current_max_segments)


func _physics_process(delta: float) -> void:
	add_point(player.position)
	if get_point_count() > current_max_segments:
		remove_point(0)
