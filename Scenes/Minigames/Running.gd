extends Node2D


var is_right = false
var is_running = false

#Load the resourse using preload
var next_lvl_screen = preload("res://Scenes/next_lvl_screen.tscn")
#Make instance
var next_lvl_screen_INST = next_lvl_screen.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = GlobalVariables.timer_length + GlobalVariables.mid_len_game
	$Timer.start()
	$Ninja.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GlobalVariables.current_time_left = $Timer.get_time_left()
	if !is_running && $Ninja.animation == "running":
		$Ninja.animation = "idle"
			
	elif is_running && $Ninja.animation == "idle":
		$Ninja.animation = "running"
		var t = Timer.new()
		t.set_wait_time(2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		is_running = false
		$Ninja.animation = "idle"
			
	elif $Ninja.animation == "falling":
		print("fell")
		var t = Timer.new()
		t.set_wait_time(2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		is_running = false
		$Ninja.animation = "idle"
	
	if $ProgressBar.value == $ProgressBar.max_value:
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


func _on_Left_button_pressed():
	if !is_right:
		is_right = true
		$ProgressBar.value += 1
		$"Buttons/Left button/LeftBreathSound".play()
		is_running = true
	else:
		#Make a slight gameover animation or change sprite where the guy trips
		$ProgressBar.value -= 1
		is_running = false
		$"Hurt Overlay".modulate.a = .6
		$"Hurt Overlay/Opacity_Animation".interpolate_property($"Hurt Overlay", "modulate", Color(1, 0, 0, .6), Color(1, 0, 0, 0), .8, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$"Hurt Overlay/Opacity_Animation".start()
		$Ninja.animation = "falling"


func _on_Right_button_pressed():
	if is_right:
		is_right = false
		$ProgressBar.value += 1
		$"Buttons/Right button/RightBreathSound".play()
		is_running = true
	else:
		#Make a slight gameover animation or change sprite where the guy trips
		$ProgressBar.value -= 1
		is_running = false
		$"Hurt Overlay".modulate.a = .6
		$"Hurt Overlay/Opacity_Animation".interpolate_property($"Hurt Overlay", "modulate", Color(1, 0, 0, .6), Color(1, 0, 0, 0), .8, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$"Hurt Overlay/Opacity_Animation".start()
		$Ninja.animation = "falling"


func _on_Timer_timeout():
	GlobalVariables.is_gameover = true
