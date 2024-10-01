extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _move_start_label():
	var t = Timer.new()
	t.set_wait_time(1)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	#Remove the "START" label
	$Tween.interpolate_property(self, "position", self.position, Vector2(-576, 0), .6, Tween.TRANS_QUAD, Tween.EASE_IN)
	$Tween.start()
