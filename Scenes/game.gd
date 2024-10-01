extends Node2D


var i = 0
var minigame
var minigame_loc
var minigame_loc_str
var minigame_INST
var first_game_loaded = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer/ProgressBar.hide()
	$Timer/ProgressBar.max_value = GlobalVariables.timer_length
	
	GlobalVariables.score = 0
	GlobalVariables.timer_length = 10
	
	$StartLabel._move_start_label()
	
	$GameMusic/Tween.interpolate_property($GameMusic, "volume_db", -60, -17, 1.5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$GameMusic/Tween.start()
	
	var t = Timer.new()
	t.set_wait_time(2.4)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	_load_current_game()
	
	$StartLabel/Label.queue_free()
	
	$Timer/ProgressBar.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariables.quit_game_scene == true:
		self.queue_free()
		GlobalVariables.quit_game_scene = false
		
	if GlobalVariables.is_gameover == true:
		$Timer/ProgressBar.hide()
		#Fade out music but I cant because it instantly goes into gameover scene
		$GameMusic/Tween.interpolate_property($GameMusic, "volume_db", -17, -60, 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$GameMusic/Tween.start()
		var gameover_loc_str = "res://Scenes/gameover.tscn"
		var gameover = load(gameover_loc_str)
		#Make instance
		var gameover_INST = gameover.instance()
		self.add_child(gameover_INST)
		GlobalVariables.is_gameover = false
		
	if first_game_loaded == true:
		if $Frame.get_child_count() == 0:
			_load_current_game()
	$Score/Label.text = "Score: %s" % str(GlobalVariables.score)
	
	
func _on_Score_Timer_timeout():
	GlobalVariables.score += 1
	
	
func _load_current_game():#resets the loads and reshuffle after finishing every minigame
	if i > GlobalVariables.minigames_list.size()-1:
		i = 0
		GlobalVariables.round_number += 1
		GlobalVariables._reshuffle_games()
		if GlobalVariables.timer_length > 2.5:
			GlobalVariables.timer_length -= .5
			$Timer/ProgressBar.max_value = GlobalVariables.timer_length
			
	#load current game scene
	var current_game = GlobalVariables.minigames_list[i]
	minigame_loc_str = "res://Scenes/Minigames/%s.tscn" % current_game
	minigame = load(minigame_loc_str)
	#Make instance
	minigame_INST = minigame.instance()
	$Frame.add_child(minigame_INST)
	i += 1
	first_game_loaded = true
	
	
	$Timer/ProgressBar.max_value = GlobalVariables.timer_length
	
	
	
	$Timer/ProgressBar.show()
