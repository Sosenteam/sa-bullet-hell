extends Control

@onready var blue_health = $"Bars/BlueHealth"
@onready var red_health = $"Bars/RedHealth"

@onready var start_screen = $StartScreen
@onready var death_screen = $DeathScreen
@onready var level_rows = $StartScreen/LevelRows
@onready var death_text = $DeathScreen/DeathScreen/DeathText
@onready var title = $StartScreen/Title

@onready var player_mode_btn = $StartScreen/PlayerModeBtn
var icon_1p = preload("res://user_interface/1-player.png")
var icon_2p = preload("res://user_interface/2-player.png")

@onready var level_row_scene = preload("res://user_interface/levelRow.tscn")

var current_level_idx = 0
var levels = [LevelOne, LevelTest, LevelAlec]

func _ready() -> void:
	Global.ui = self
	size = Global.screen_size
	$Bars.size = size
	
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	_animate_start_screen()
	get_tree().paused = true

func _animate_start_screen():
	for i in range(25):
		var bullet = Panel.new()
		var style = StyleBoxFlat.new()
		style.bg_color = Color(1.0, 0.2, 0.4, 0.3) if i % 2 == 0 else Color(0.2, 0.6, 1.0, 0.3)
		style.corner_radius_top_left = 100
		style.corner_radius_top_right = 100
		style.corner_radius_bottom_left = 100
		style.corner_radius_bottom_right = 100
		bullet.add_theme_stylebox_override("panel", style)
		var size_val = randf_range(20, 150)
		bullet.size = Vector2(size_val, size_val)
		bullet.position = Vector2(randf_range(0, Global.screen_size.x), randf_range(0, Global.screen_size.y))
		start_screen.add_child(bullet)
		start_screen.move_child(bullet, 0)
		var bt = create_tween().set_loops()
		var target_pos = bullet.position + Vector2(randf_range(-300, 300), randf_range(-300, 300))
		var dur = randf_range(3.0, 7.0)
		bt.tween_property(bullet, "position", target_pos, dur).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
		bt.tween_property(bullet, "position", bullet.position, dur).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	#title flaoting
	var title_tween = create_tween().set_loops()
	title_tween.tween_property(title, "position:y", title.position.y+30, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	title_tween.tween_property(title, "position:y", title.position.y, 2.0).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
	
	var first_btn = null
	for i in levels.size():
		var temp_level = levels[i].new()
		var row = level_row_scene.instantiate()
		level_rows.add_child(row)
		row.init(str(i + 1), temp_level.level_name, temp_level.length, temp_level.difficulty, i)
		row.level_selected.connect(start_level)
		
		if first_btn == null:
			first_btn = row.button
	
	player_mode_btn.icon = icon_2p if Global.num_players == 2 else icon_1p
	$StartScreen/PlayerModeBtn/OtherIcon.icon = icon_2p if Global.num_players == 1 else icon_1p
	player_mode_btn.pressed.connect(func():
		Global.num_players = 1 if Global.num_players == 2 else 2
		player_mode_btn.icon = icon_2p if Global.num_players == 2 else icon_1p
		$StartScreen/PlayerModeBtn/OtherIcon.icon = icon_2p if Global.num_players == 1 else icon_1p
		var t = create_tween()
		t.tween_property($StartScreen/PlayerModeBtn/OtherIcon/Swap,"rotation_degrees",$StartScreen/PlayerModeBtn/OtherIcon/Swap.rotation_degrees+360,0.4).set_trans(Tween.TRANS_CUBIC)
	)
	
	player_mode_btn.focus_entered.connect(func():$StartScreen/PlayerModeBtn/OtherIcon.show())
	player_mode_btn.focus_exited.connect(func():$StartScreen/PlayerModeBtn/OtherIcon.hide())
	

	if first_btn:
		player_mode_btn.focus_neighbor_bottom = first_btn.get_path()
		first_btn.focus_neighbor_top = player_mode_btn.get_path()

	await get_tree().process_frame
	if player_mode_btn:
		player_mode_btn.grab_focus()

func start_level(idx):
	var t = create_tween()
	t.tween_property(start_screen, "modulate:a", 0.0, 0.3)
	t.tween_callback(func():
		start_screen.hide()
		get_tree().paused = false
		if Global.has_method("start_selected_level"):
			Global.start_selected_level(levels[idx])
	)

func _input(event):
	if death_screen.visible and death_screen.get_child(0).get_time_left() < 0.5 and (event is InputEventKey or event is InputEventJoypadButton) and event.is_pressed():
		get_tree().paused = false
		get_tree().reload_current_scene()

func update_health(hp,player_id):
	var bar = blue_health if player_id == 1 else red_health
	if hp < bar.value:
		var t = create_tween()
		var orig_pos = bar.position
		var orig_rot = bar.rotation
		
		t.tween_property(bar, "scale", Vector2(1.2, 1.4), 0.05).set_trans(Tween.TRANS_BOUNCE)
		t.parallel().tween_property(bar, "rotation", orig_rot + 0.1, 0.05)
		t.parallel().tween_property(bar, "position", orig_pos + Vector2(0, +15), 0.2).set_trans(Tween.TRANS_CIRC)
		t.tween_property(bar, "rotation", orig_rot - 0.1, 0.05)
		t.tween_property(bar, "rotation", orig_rot, 0.05)
		t.parallel().tween_property(bar, "scale", Vector2(1.0, 1.0), 0.1).set_trans(Tween.TRANS_BOUNCE)
		t.tween_property(bar, "rotation", orig_rot, 0.05)
	bar.value = hp
	bar.get_child(0).text = str(hp)
	

func show_death_screen(winner_text):
	$DeathScreen/Timer.start(3.0)
	var orig_pos = death_screen.position
	death_screen.position.y-=death_screen.size.y
	if winner_text.contains("BLUE"):
		$DeathScreen/DeathScreen.color = Color("87CEEB")
	if winner_text.contains("RED"):
		$DeathScreen/DeathScreen.color = Color("FFA6AC")
	death_screen.show()
	death_text.text = winner_text + "\nPRESS ANY KEY TO RESTART"
	get_tree().paused = true
	var t = create_tween()
	t.tween_property(death_screen, "position", orig_pos, 1.5).set_trans(Tween.TRANS_BOUNCE)
	#t.tween_property(death_screen, "modulate:a", 1.0, 1.0)
	
