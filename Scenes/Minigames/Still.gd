extends Node2D


#Load the resourse using preload
var next_lvl_screen = preload("res://Scenes/next_lvl_screen.tscn")
#Make instance
var next_lvl_screen_INST = next_lvl_screen.instance()

var shake_points = 0
var ended = false
var detectInput = true

var last_movementx = 0
var difference_accelerometerx = 0

var last_movementy = 0
var difference_accelerometery = 0

var last_movementz = 0
var difference_accelerometerz = 0

var do_once = false
var do_once2 = false
var do_once3 = false

var change_anim = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = GlobalVariables.timer_length + GlobalVariables.long_len_game
	$Timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if detectInput:
		difference_accelerometerx = Input.get_accelerometer().x - last_movementx
		difference_accelerometery = Input.get_accelerometer().y - last_movementy
		difference_accelerometerz = Input.get_accelerometer().z - last_movementz
	else:
		difference_accelerometerx = 0
		difference_accelerometery = 0
		difference_accelerometerz = 0
		
	GlobalVariables.current_time_left = $Timer.get_time_left()
	if shake_points >= 75:
		if do_once3 == false:
			$Screaming.play()
			print("test1")
			$"TightRope Walker".animation = "left falling"
			do_once3 = true
				
		var t2 = Timer.new()
		t2.set_wait_time(1.5)
		t2.set_one_shot(true)
		self.add_child(t2)
		t2.start()
		yield(t2, "timeout")
		if do_once2 == false:
			print(str(shake_points))
			ended = true
			GlobalVariables.is_gameover = true
			shake_points = 0
			$Timer.stop()
			do_once2 = true
	if ended == false:
		$Label.text = str(difference_accelerometerx) + "\n" + str(difference_accelerometery) + " \n" + str(difference_accelerometerz) + "\n" + str(shake_points)
		if difference_accelerometerx <= -0.25 or difference_accelerometerx >= 0.25:
			shake_points+=1
			if change_anim == true:
				_set_leaning_animation()

		elif difference_accelerometery <= -0.25 or difference_accelerometery >= 0.25:
			shake_points+=1
			if change_anim == true:
				_set_leaning_animation()
			
		elif difference_accelerometerz <= -0.25 or difference_accelerometerz >= 0.25:
			shake_points+=1
			if change_anim == true:
				_set_leaning_animation()
			
		elif Input.is_key_pressed(KEY_L):
			shake_points+=1
			if $"TightRope Walker".animation == "idle":
				if do_once == false:
					$"TightRope Walker".animation = "left leaning"
					do_once = true
					
		else:
			if $"TightRope Walker".animation != "idle":
				$"TightRope Walker".animation = "idle"
				do_once = false
		last_movementx = Input.get_accelerometer().x
		last_movementy = Input.get_accelerometer().y
		last_movementz = Input.get_accelerometer().z

func _set_leaning_animation():
	if $"TightRope Walker".animation == "idle":
		$"TightRope Walker".animation = "left leaning"
		change_anim = false
		var t = Timer.new()
		t.set_wait_time(1.5)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		change_anim = true

func _on_Timer_timeout():
	detectInput = false
	add_child(next_lvl_screen_INST)
	#Add to the score
	GlobalVariables.score += 20
	#wait a little
	var t = Timer.new()
	t.set_wait_time(2.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	self.queue_free()
