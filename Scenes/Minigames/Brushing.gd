extends Node2D


#Load the resourse using preload
var next_lvl_screen = preload("res://Scenes/next_lvl_screen.tscn")
#Make instance
var next_lvl_screen_INST = next_lvl_screen.instance()


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVariables.stain_destroyed = 0
	$Timer.wait_time = GlobalVariables.timer_length + GlobalVariables.short_len_game
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GlobalVariables.current_time_left = $Timer.get_time_left()
	if GlobalVariables.stain_destroyed == 401:
		$TeethDetection/BrushingSound.stop()
		$Timer.stop()
		add_child(next_lvl_screen_INST)
		
		#Add to the score
		#GlobalVariables.score += 20
		#wait a little
		var t = Timer.new()
		t.set_wait_time(2.5)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		self.queue_free()


func _on_Timer_timeout():
	if $TeethDetection/BrushingSound.playing:
		$TeethDetection/BrushingSound.stop()
	GlobalVariables.is_gameover = true
