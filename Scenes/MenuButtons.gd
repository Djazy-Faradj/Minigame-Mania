extends Node2D

#Load the resourse using preload
var game = preload("res://Scenes/game.tscn")
var options = preload("res://Scenes/Options.tscn")
var credits = preload("res://Scenes/Credits.tscn")

#Make instance
var game_INST = game.instance()
var options_INST = options.instance()
var credits_INST = credits.instance()

var eraser_anim_started = false
var tween_opacity_values = [.3, .95]

var start_game = false
var open_options = false
var open_credits = false


# Called when the node enters the scene tree for the first time.
func _ready():
	var t = Timer.new()
	t.set_wait_time(10)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	_start_tween()
	t = Timer.new()
	t.set_wait_time(2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	_start_banner_tweens()
	$PlayButton/TextureButton.disabled = false
	$Banners/creds_node/creds_btn.disabled = false
	$Banners/history_node/history_btn.disabled = false
	$Banners/quit_node/quit_btn.disabled = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariables.make_menubuttons_comeback == true:
		_bring_back_buttons()
		randomize()
		GlobalVariables.minigames_list.shuffle()
	GlobalVariables.make_menubuttons_comeback = false

func _start_tween():
	print("PlayButton: _start_tween")
	$PlayButton/TextureButton/Label/Tween.interpolate_property($PlayButton/TextureButton/Label, "modulate", Color(1, 1, 1, tween_opacity_values[0]), Color(1, 1, 1, tween_opacity_values[1]), 1, Tween.TRANS_QUART, Tween.EASE_IN)
	$PlayButton/TextureButton/Label/Tween.start()
func _start_banner_tweens():
	$Banners/history_node/Tween.interpolate_property($Banners/history_node, "position", Vector2(590, 432), Vector2(256, 432), 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Banners/history_node/Tween.start()
	
	var t = Timer.new()
	t.set_wait_time(.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	$Banners/creds_node/Tween.interpolate_property($Banners/creds_node, "position", Vector2(590, 602), Vector2(294, 602), 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Banners/creds_node/Tween.start()
	
	t = Timer.new()
	t.set_wait_time(.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	$Banners/quit_node/Tween.interpolate_property($Banners/quit_node, "position", Vector2(590, 708), Vector2(294, 708), 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Banners/quit_node/Tween.start()

func _bring_back_buttons():
	print("PlayButton: _bring_back_buttons")
	$PlayButton/Tween.interpolate_property($PlayButton, "position", Vector2(125, 1300), Vector2(125, 830), 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$PlayButton/Tween.start()
	#reLoad the resourse using preload
	game = preload("res://Scenes/game.tscn")
	options = preload("res://Scenes/Options.tscn")
	credits = preload("res://Scenes/Credits.tscn")
	#Make instance
	game_INST = game.instance()
	options_INST = options.instance()
	credits_INST = credits.instance()
	_bring_back_banner_buttons()
func _bring_back_banner_buttons():
	print("_bring_back_banner_buttons")
	$Banners/history_node/Tween.interpolate_property($Banners/history_node, "position", Vector2(590, 432), Vector2(256, 432), 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Banners/history_node/Tween.start()
	
	var t = Timer.new()
	t.set_wait_time(.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	$Banners/creds_node/Tween.interpolate_property($Banners/creds_node, "position", Vector2(590, 602), Vector2(294, 602), 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Banners/creds_node/Tween.start()
	
	t = Timer.new()
	t.set_wait_time(.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	$Banners/quit_node/Tween.interpolate_property($Banners/quit_node, "position", Vector2(590, 708), Vector2(294, 708), 1, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Banners/quit_node/Tween.start()

func _menu_out_animations_handler():
	$PlayButton/TextureButton.disabled = true
	$Banners/creds_node/creds_btn.disabled = true
	$Banners/history_node/history_btn.disabled = true
	$Banners/quit_node/quit_btn.disabled = true
	print("PlayButton: _menu_out_animations_handler")
	if start_game:
		get_tree().get_root().get_node("Mainmenu/SFX/menumusic/Tween").interpolate_property(get_tree().get_root().get_node("Mainmenu/SFX/menumusic"), "volume_db", -17, -60, 2, Tween.TRANS_QUINT, Tween.EASE_IN)
		get_tree().get_root().get_node("Mainmenu/SFX/menumusic/Tween").start()
	
		get_tree().get_root().get_node("Mainmenu/Background/Title")._fade_out()
		$PlayButton/Tween.interpolate_property($PlayButton, "position", Vector2(125, 830), Vector2(125, 1300), 1, Tween.TRANS_ELASTIC, Tween.EASE_IN)
		$PlayButton/Tween.start()
		var t = Timer.new()
		t.set_wait_time(.15)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
	
	$Banners/history_node/Tween.interpolate_property($Banners/history_node, "position", Vector2(256, 432), Vector2(590, 432), 1, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	$Banners/history_node/Tween.start()
	
	var t = Timer.new()
	t.set_wait_time(.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	$Banners/creds_node/Tween.interpolate_property($Banners/creds_node, "position", Vector2(294, 602), Vector2(590, 602), 1, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	$Banners/creds_node/Tween.start()
	
	t = Timer.new()
	t.set_wait_time(.1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	$Banners/quit_node/Tween.interpolate_property($Banners/quit_node, "position", Vector2(294, 708), Vector2(590, 708), 1, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	$Banners/quit_node/Tween.start()
	
	t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	if start_game == true:
		get_tree().get_root().get_node("Mainmenu/Eraser/AnimationPlayer").play("Erase Menu")
		
		t = Timer.new()
		t.set_wait_time(1.75)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		
		get_tree().get_root().get_node("Mainmenu/Eraser/AnimationPlayer").play_backwards()
		eraser_anim_started = false
		get_tree().get_root().add_child(game_INST)
		$PlayButton/TextureButton.disabled = false
		$Banners/history_node/history_btn.disabled = false
		$Banners/creds_node/creds_btn.disabled = false
		$Banners/quit_node/quit_btn.disabled = false
		start_game = false
	elif open_options == true:
		get_tree().get_root().add_child(options_INST)
		$PlayButton/TextureButton.disabled = false
		$Banners/history_node/history_btn.disabled = false
		$Banners/creds_node/creds_btn.disabled = false
		$Banners/quit_node/quit_btn.disabled = false
		open_options = false
	elif open_credits == true:
		get_tree().get_root().add_child(credits_INST)
		$PlayButton/TextureButton.disabled = false
		$Banners/history_node/history_btn.disabled = false
		$Banners/creds_node/creds_btn.disabled = false
		$Banners/quit_node/quit_btn.disabled = false
		open_credits = false


func _on_Tween_tween_completed(object, key):
	tween_opacity_values.invert()
	_start_tween()
	$PlayButton/AnimationPlayer.play("PlayButton_FadeIn", 1, 1.2)


func _on_AnimationPlayer_animation_started(anim_name):
	eraser_anim_started = true


func _on_PlayButton_pressed():
	print("PlayButton: _on_playbutton_pressed")
	get_tree().get_root().get_node("Mainmenu/SFX/selectSound").play()
	if !open_options && !open_credits && !start_game:
		start_game = true
	if !eraser_anim_started:
		_menu_out_animations_handler()
func _on_history_btn_pressed():
	get_tree().get_root().get_node("Mainmenu/SFX/selectSound").play()
	if !start_game && !open_credits && !open_options:
		print("opening..")
		open_options = true
	if !eraser_anim_started:
		_menu_out_animations_handler()
func _on_creds_btn_pressed():
	get_tree().get_root().get_node("Mainmenu/SFX/selectSound").play()
	if !start_game && !open_options && !open_credits:
		open_credits = true
	if !eraser_anim_started:
		_menu_out_animations_handler()
func _on_quit_btn_pressed():
	if !eraser_anim_started:
		get_tree().quit()
