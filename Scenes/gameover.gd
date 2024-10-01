extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	print("googa")
	GlobalVariables.round_number = 0
	var end_score = str(GlobalVariables.score)
	$Label.text = "Score: %s" % end_score
	
	$GameoverSound/Tween.interpolate_property($GameoverSound, "volume_db", -60, -17, 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$GameoverSound/Tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
