class_name SyncLevel extends Node

var manager: Node
var shapes: Array[Node2D]
var music_player: AudioStreamPlayer
var level_name: String = "Sync Level"
var difficulty: String = "1/5"

var music: AudioStream = null

var _length: String = "0:00"
var length: String:
	get:
		if music:
			var seconds = music.get_length()
			var mins = int(seconds) / 60
			var secs = int(seconds) % 60
			return "%d:%02d" % [mins, secs]
		return _length
	set(value):
		_length = value
		
var output_latency:float

var timeline: Array[Dictionary]





var current_event_index: int = 0

func _init(mgr: Node = null, shps: Array[Node2D] = [], mp: Node = null):
	manager = mgr
	shapes = shps
	music_player = mp

func play(level_node: Node):
	current_event_index = 0
	timeline.sort_custom(func(a, b): return a.t < b.t) # Ensure sorted by time
	music_player.play()
	output_latency = AudioServer.get_output_latency()
	music_player.finished.connect(end)

func _process(_delta):
	#print("proc	essing")
	if not music_player.playing:
		print("no music")
		return
		
	var current_time = music_player.get_playback_position()
	var exact_time = music_player.get_playback_position() + AudioServer.get_time_since_last_mix() - output_latency
	
	# Trigger all events that are due
	while current_event_index < timeline.size() and exact_time  >= timeline[current_event_index]["t"]:
		timeline[current_event_index].a.call()
		current_event_index += 1
func end():
	queue_free()
