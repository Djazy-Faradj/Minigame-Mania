extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var t = Timer.new()
	t.set_wait_time(7.5)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	_bring_back_title()
	get_tree().get_root().get_node("Mainmenu/SFX/menumusic").play()
	$GameNameSound.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if GlobalVariables.make_titlelabel_comeback == true:
		_bring_back_title()
		GlobalVariables.make_titlelabel_comeback = false


func _fade_out():
	$Tween.interpolate_property(self, "position", Vector2(20, 0), Vector2(-460, 0), 1, Tween.TRANS_ELASTIC, Tween.EASE_IN)
	$Tween.start()
	var t = Timer.new()
	t.set_wait_time(.8)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	$SlideSound.play()
	
func _bring_back_title():
	$Tween.interpolate_property(self, "position", Vector2(-460, 0), Vector2(20, 0), 1.2, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.start()
	$BounceSound.play()
	var t = Timer.new()
	t.set_wait_time(1.7)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	yield(t, "timeout")
	if get_tree().get_root().get_node("Mainmenu/SFX/menumusic").get_volume_db() != -17:
		get_tree().get_root().get_node("Mainmenu/SFX/menumusic/Tween").interpolate_property(get_tree().get_root().get_node("Mainmenu/SFX/menumusic"), "volume_db", -60, -17, 1, Tween.TRANS_QUINT, Tween.EASE_IN)
		get_tree().get_root().get_node("Mainmenu/SFX/menumusic/Tween").start()


func _on_menumusic_finished():
	get_tree().get_root().get_node("Mainmenu/SFX/menumusic").play()
