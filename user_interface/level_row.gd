extends Control

signal level_selected(idx)

@onready var rowLabel = $Panel/MarginContainer/MarginContainer/HBoxContainer/Row
@onready var levelLabel = $"Panel/MarginContainer/MarginContainer/HBoxContainer/Level Name"
@onready var durationLabel = $Panel/VSeparator/Time
@onready var difficultyLabel = $Panel/VSeparator/Difficulty
@onready var button = $Button

var level_index = 0

func _ready() -> void:
	button.pressed.connect(func(): level_selected.emit(level_index))
	button.focus_entered.connect(_on_focus_entered)
	button.focus_exited.connect(_on_focus_exited)

func init(row, level, duration, difficulty, idx):
	level_index = idx
	rowLabel.text = str(row)
	levelLabel.text = level
	durationLabel.text = duration
	difficultyLabel.text = difficulty

func _on_focus_entered():
	var t = create_tween().set_parallel(true)
	t.tween_property(self, "scale", Vector2(1.2, 1.2), 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	
	var float_tween = create_tween().set_loops()
	float_tween.tween_property(self, "rotation_degrees", 2.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	float_tween.tween_property(self, "rotation_degrees", -2.0, 1.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	set_meta("float_tween", float_tween)

func _on_focus_exited():
	if has_meta("float_tween"):
		get_meta("float_tween").kill()
		remove_meta("float_tween")
		
	var t = create_tween().set_parallel(true)
	t.tween_property(self, "scale", Vector2(1.0, 1.0), 0.3).set_ease(Tween.EASE_OUT)
	t.tween_property(self, "rotation_degrees", 0.0, 0.2)
	
