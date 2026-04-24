extends Line2D

@onready var player = $".."
@export var max_segments = 6


func _ready() -> void:
	set_as_top_level(true)
	points.resize(max_segments)


func _physics_process(delta: float) -> void:
	add_point(player.position)
	if get_point_count() > max_segments:
		remove_point(0)
