extends Node2D


#Load the resourse using preload
var next_lvl_screen = preload("res://Scenes/next_lvl_screen.tscn")
#Make instance
var next_lvl_screen_INST = next_lvl_screen.instance()

var nuke_played = false
var alarm_played = false

var final_press = false

var shake_multiplier = 4
var is_shaking = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = GlobalVariables.timer_length + GlobalVariables.short_len_game
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GlobalVariables.current_time_left = $Timer.get_time_left()
	#print($Timer.get_time_left())
	if $ProgressBar.value >= 20:
		$Timer.stop()
		if is_shaking:
			get_parent().set_position(Vector2(0 + rand_range(-1.0, 1.0) * shake_multiplier, 0 + rand_range(-1.0, 1.0) * shake_multiplier))
		if nuke_played == false:
			$"Explosion Overlay".modulate.a = 1
			$"Explosion Overlay/Opacity_Animation".interpolate_property($"Explosion Overlay", "modulate", Color(1, .7, .7, 1), Color(1, 0, 0, 0), 3, Tween.TRANS_QUAD, Tween.EASE_IN)
			$"Explosion Overlay/Opacity_Animation".start()
			$Explosion.animation = "explosion"
			$Explosion.play()
			$"nuke audio".play()
			nuke_played = true
		if alarm_played == false:
			$"alarm audio".play()
			alarm_played = true
		var t = Timer.new()
		t.set_wait_time(3)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		is_shaking = false
		add_child(next_lvl_screen_INST)
		#Add to the score
		#GlobalVariables.score += 20
		#wait a little
		var t2 = Timer.new()
		t2.set_wait_time(2.5)
		t2.set_one_shot(true)
		self.add_child(t2)
		t2.start()
		yield(t2, "timeout")
		get_parent().queue_free()


func _on_TextureButton_pressed():
	$ProgressBar.value += 1
	print($ProgressBar.value)
	if $ProgressBar.value == 1:
			$PressSounds/press1.play()
	if $ProgressBar.value == 2:
			$PressSounds/press2.play()
	if $ProgressBar.value == 3:
			$PressSounds/press3.play()
	if $ProgressBar.value == 4:
			$PressSounds/press4.play()
	if $ProgressBar.value == 5:
			$PressSounds/press5.play()
	if $ProgressBar.value == 6:
			$PressSounds/press6.play()
	if $ProgressBar.value == 7:
			$PressSounds/press7.play()
	if $ProgressBar.value == 8:
			$PressSounds/press8.play()
	if $ProgressBar.value == 9:
			$PressSounds/press9.play()
	if $ProgressBar.value == 10:
			$PressSounds/press10.play()
	if $ProgressBar.value == 11:
			$PressSounds/press11.play()
	if $ProgressBar.value == 12:
			$PressSounds/press12.play()
	if $ProgressBar.value == 13:
			$PressSounds/press13.play()
	if $ProgressBar.value == 14:
			$PressSounds/press14.play()
	if $ProgressBar.value == 15:
			$PressSounds/press15.play()
	if $ProgressBar.value == 16:
			$PressSounds/press16.play()
	if $ProgressBar.value == 17:
			$PressSounds/press17.play()
	if $ProgressBar.value == 18:
			$PressSounds/press18.play()
	if $ProgressBar.value == 19:
			$PressSounds/press19.play()
	if $ProgressBar.value == 20 && final_press == false:
			$PressSounds/press20.play()
			final_press = true
	if $ProgressBar.value == 20 && final_press == true:
			$PressSounds/end_press.play()

func _on_Timer_timeout():
	GlobalVariables.is_gameover = true
