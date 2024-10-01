extends Node


# Declare member variables here. Examples:
var score = 0
var minigames_list = ["Tap20", "SodaShake", "Brushing", "Running", "Still"]
var current_game = ""
var is_gameover = false
var timer_length = 10
var make_menubuttons_comeback = false
var make_titlelabel_comeback = false
var quit_game_scene = false
var quit_options_scene = false
var quit_credits_scene = false
var current_time_left = timer_length
var hide_timerbar = false
var stain_destroyed = 0
var game_reshuffled_sound = false
var show_splashscreen = true
var round_number = 0
var game_played = 0

var short_len_game = 0
var mid_len_game = 1
var long_len_game = 2


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	minigames_list.shuffle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _reshuffle_games():
	game_reshuffled_sound = true
	minigames_list.shuffle()
