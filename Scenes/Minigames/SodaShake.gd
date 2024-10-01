extends Node2D


var progressbar = 0
var is_shaking = false
var explosion_sound_once = false

#Load the resourse using preload
var next_lvl_screen = preload("res://Scenes/next_lvl_screen.tscn")
#Make instance
var next_lvl_screen_INST = next_lvl_screen.instance()


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = GlobalVariables.timer_length + GlobalVariables.long_len_game
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GlobalVariables.current_time_left = $Timer.get_time_left()
	if progressbar >= 500:
		if !explosion_sound_once:
			$Timer.stop()
			$Soda/AnimatedSprite.animation = "explosion"
			$ShakingBottleSound.stop()
			$BottleExplosionSound.play()
			explosion_sound_once = true
		var t = Timer.new()
		t.set_wait_time(1)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
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
		self.queue_free()
		
	var accelerometer_x = Input.get_accelerometer().x
	var accelerometer_y = Input.get_accelerometer().y
	var accelerometer_z = Input.get_accelerometer().z
	
	if accelerometer_x <= -12 or accelerometer_x >= 12 or accelerometer_y <= -12 or accelerometer_y >= 12 or accelerometer_z <= -12 or accelerometer_z >= 12:
		_phone_mouvement(accelerometer_x, accelerometer_y, accelerometer_z)
		
	elif Input.is_key_pressed(KEY_L):
		_phone_mouvement(25, 25, 25)
		
	else:
		var t2 = Timer.new()
		t2.set_wait_time(.6)
		t2.set_one_shot(true)
		self.add_child(t2)
		t2.start()
		yield(t2, "timeout")
		if is_shaking == false:
			$Soda/AnimatedSprite.animation = "idle"
			$ShakingBottleSound.stop()

func _phone_mouvement(var x, y, z):
	var avg_val = abs((x + y + z) / 3)
	progressbar+=1.5 * avg_val/5
	print("moving")
	if $Soda/AnimatedSprite.animation != "shaking":
		is_shaking = true
		$Soda/AnimatedSprite.animation = "shaking"
		$ShakingBottleSound.play()
		var t2 = Timer.new()
		t2.set_wait_time(1)
		t2.set_one_shot(true)
		self.add_child(t2)
		t2.start()
		yield(t2, "timeout")
		is_shaking = false

func _on_Timer_timeout():
	GlobalVariables.is_gameover = true

