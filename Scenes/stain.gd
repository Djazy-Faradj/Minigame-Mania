extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	randomize()
	var rand_num = int(rand_range(-2, 2))
	self.rotate(rand_num)

func _on_Stain_body_entered(body):
	GlobalVariables.stain_destroyed += 1
	self.queue_free()
