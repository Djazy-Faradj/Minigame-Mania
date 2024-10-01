extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#$ProgressBar.hide()
	#$ProgressBar.max_value = GlobalVariables.timer_length


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$ProgressBar.value = $ProgressBar.max_value - GlobalVariables.current_time_left
	
	if GlobalVariables.hide_timerbar == true:
		$ProgressBar.hide()
		GlobalVariables.hide_timerbar = false
