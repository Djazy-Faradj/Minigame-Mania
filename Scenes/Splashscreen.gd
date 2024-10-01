extends VideoPlayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if GlobalVariables.show_splashscreen:
		var t = Timer.new()
		t.set_wait_time(.37)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		yield(t, "timeout")
		$AudioStreamPlayer.play()
		var t2 = Timer.new()
		t2.set_wait_time(6.5)
		t2.set_one_shot(true)
		self.add_child(t2)
		t2.start()
		yield(t2, "timeout")
		GlobalVariables.show_splashscreen = false
		get_node("../BG_Splashscreen").queue_free()
		self.queue_free()
	else:
		self.queue_free()
