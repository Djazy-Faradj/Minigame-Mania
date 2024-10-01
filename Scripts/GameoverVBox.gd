extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var t = Timer.new()
	t.set_wait_time(1.2)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	
	$Tween.interpolate_property(get_parent(), "position", get_parent().position, Vector2(-576, 0), 2, Tween.TRANS_QUINT, Tween.EASE_OUT)
	$Tween.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Quit_pressed():
	get_tree().quit()


func _on_Retry_pressed():
	GlobalVariables.make_menubuttons_comeback = true
	GlobalVariables.make_titlelabel_comeback = true
	GlobalVariables.quit_game_scene = true
