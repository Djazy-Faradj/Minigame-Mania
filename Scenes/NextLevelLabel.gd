extends Node2D


# Declare member variables here. Examples:
# var a = 2
var text_list = ["NEXT!!", "GO! GO! GO!", "LET'S GOOO!", "HURRY UPPP!", "ALRIGHT!", "GOOD JOB!", "YOU GOT IT!", "REEEE"]


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalVariables.game_played += 1
	randomize()
	print(GlobalVariables.round_number)
	if GlobalVariables.round_number > 3 && GlobalVariables.round_number < 8:
		var pitch_scale = 1 + ((GlobalVariables.round_number-4) / 3.0)
		print("%s" % pitch_scale)
		$AudioStreamPlayer.set_pitch_scale(pitch_scale)
		$AudioStreamPlayer.play()
	var rand_text = int(rand_range(0, 6))
	
	$Label.text = text_list[rand_text]
	GlobalVariables.hide_timerbar = true
	
	var t = Timer.new()
	t.set_wait_time(.6)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	$Tween.interpolate_property(self, "position", self.position, Vector2(-576, 0), .35, Tween.TRANS_QUAD, Tween.EASE_OUT)
	$Tween.start()

	if GlobalVariables.game_played == GlobalVariables.minigames_list.size():
		$ReshuffleSound.play()
		GlobalVariables.game_played = 0
		print(GlobalVariables.game_played)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	GlobalVariables.score += 20
