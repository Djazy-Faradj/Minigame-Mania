extends VBoxContainer


#Load the resourse using preload
var game = preload("res://Scenes/game.tscn")
#Make instance
var game_INST = game.instance()


# Called when the node enters the scene tree for the first time.
func _ready():
	var t = Timer.new()
	t.set_wait_time(5.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	#$menumusic.play()
	#$menumusic/Tween.interpolate_property($menumusic, "volume_db", -60, -17, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
	#$menumusic/Tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariables.make_menubuttons_comeback == true:
		_bring_back_buttons()
		#$menumusic/Tween.interpolate_property($menumusic, "volume_db", -60, -17, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		#$menumusic/Tween.start()
		randomize()
		GlobalVariables.minigames_list.shuffle()
		GlobalVariables.make_menubuttons_comeback = false


func _on_Quit_pressed():
	$selectSound.play()
	get_tree().quit()


func _on_Play_pressed():
	var title_lbl = get_tree().get_root().get_node("Mainmenu/Background/Title")
	
	$Tween.interpolate_property(get_parent(), "position", get_parent().position, Vector2(-576, 0), 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Tween.start()
	
	$selectSound.play()
	#$menumusic/Tween.interpolate_property($menumusic, "volume_db", -17, -60, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	#$menumusic/Tween.start()
	
	title_lbl._fade_out()
	get_tree().get_root().get_node("Mainmenu/Eraser/AnimationPlayer").play("Erase Menu")
	
	var t = Timer.new()
	t.set_wait_time(.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	get_tree().get_root().get_node("Mainmenu/FadeOutWhite/Tween").interpolate_property(get_tree().get_root().get_node("Mainmenu/FadeOutWhite"), "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 1, Tween.TRANS_LINEAR, Tween.EASE_IN)
	get_tree().get_root().get_node("Mainmenu/FadeOutWhite/Tween").start()
	
	t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	t.queue_free()
	get_tree().get_root().add_child(game_INST)

func _bring_back_buttons():
	#reLoad the resourse using preload
	game = preload("res://Scenes/game.tscn")
	#Make instance
	game_INST = game.instance()
	
	get_tree().get_root().get_node("Mainmenu/FadeOutWhite").modulate.a = 0
	$Tween.interpolate_property(get_parent(), "position", get_parent().position, Vector2(0, 0), 3, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Tween.start()
	


func _on_Splashscreen_finished():
	#play the MINIGAME MANIA! SFX
	print("finished")
