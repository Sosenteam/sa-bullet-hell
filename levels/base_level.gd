class_name BaseLevel
extends Node

var manager: Node
var shapes: Array[Node2D]
var music_player: Node

var level_name: String = "Base Level"
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

func _init(mgr: Node = null, shps: Array[Node2D] = [], mp: Node = null):
	manager = mgr
	shapes = shps
	music_player = mp

func play(level_node: Node):
	pass
