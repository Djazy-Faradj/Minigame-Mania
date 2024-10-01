extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Tween.interpolate_property(self, "position", Vector2(0, 1024), Vector2(0, 0), 1.2, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariables.quit_credits_scene:
		self.queue_free()
		GlobalVariables.quit_credits_scene = false


func _on_BackButton_pressed():
	$Tween.interpolate_property(self, "position", Vector2(0, 0), Vector2(0, 1024), 1.2, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	$Tween.start()
	var t = Timer.new()
	t.set_wait_time(1.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	GlobalVariables.make_menubuttons_comeback = true
	GlobalVariables.make_titlelabel_comeback = true
	GlobalVariables.quit_credits_scene = true
