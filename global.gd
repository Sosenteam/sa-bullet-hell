extends Node

@onready var screen_size = get_viewport().get_visible_rect().size
@onready var center = screen_size/2
@onready var red_player
@onready var blue_player
var levels = []


var bad_color = Color(0.691, 0.0, 0.261, 1.0)
var indicator_color = Color(0.691, 0.0, 0.261, 0.25)
var invis_color = Color(0.691, 0.0, 0.261, 0)
var ui:Node

func update_health(hp,plid):
	ui.update_health(hp,plid)

func fail_player(plid, player):
	player.be_ghost(true)
	if(plid == 1):
		print("RED WINS")
		
		#if ui:
			#ui.show_death_screen("RED WINS!")
	if(plid == 2):
		print("BLUE WINS")
		#if ui:
			#ui.show_death_screen("BLUE WINS!")

var current_level_instance
var num_players = 2

func start_selected_level(level_class):
	var manager = get_tree().current_scene.get_node("Manager")
	var level_node = get_tree().current_scene
	var shapes = []
	if level_node.get("shapes") != null:
		shapes = level_node.shapes
	var music_player = null
	if level_node.get("music_player") != null:
		music_player = level_node.music_player
	if num_players == 1:
		red_player.queue_free()
	
	
	current_level_instance = level_class.new(manager, shapes, music_player)
	level_node.add_child(current_level_instance)
	if current_level_instance.music and music_player:
		music_player.stream = current_level_instance.music
	
	current_level_instance.play(level_node)
