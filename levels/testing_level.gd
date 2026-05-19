extends Node2D

@onready var manager = $Manager
@onready var music_player = $MusicPlayer



var shapes: Array[Node2D] = [] 
@onready var corners_and_centers = [
	Vector2(0, 0),
	Vector2(Global.center.x / 2, 0),   
	Vector2(Global.center.x, 0),      
	Vector2(Global.center.x, Global.center.y / 2), 
	Vector2(Global.center.x, Global.center.y),
	Vector2(Global.center.x / 2, Global.center.y), 
	Vector2(0, Global.center.y),    
	Vector2(0, Global.center.y / 2)   
]


func _ready() -> void:
	Global.blue_player=$Player
	Global.red_player=$Player2
	$Edges/Right.shape.distance = -Global.screen_size.x
	$Edges/Bottom.shape.distance = -Global.screen_size.y
	print("played level")
	shapes = []
	for i in 5:
		shapes.append(manager.create_shape())

func _physics_process(delta: float) -> void:
	pass
