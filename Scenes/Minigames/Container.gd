extends Container


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var stain_loc_str = "res://Scenes/stain.tscn"
	var stain = load(stain_loc_str)
	
	for i in range(0, 401):
		#Make instance
		var stain_INST = stain.instance()
		var x_coord  = rand_range(0, self.get_size().x)
		var y_coord = rand_range(0, self.get_size().y)
		stain_INST.position = Vector2(x_coord, y_coord)
		self.add_child(stain_INST)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
