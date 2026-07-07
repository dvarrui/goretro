extends Node2D

export var next_level = ""
var main_scene = "res://ui/title/title.tscn"
onready var sound = $etc/sound
onready var pause = $etc/pause
onready var points = $etc/points

func _ready():
	points.set_level_name(name)
	sound.play()

func _process(_delta):
	if get_node("wall").get_child_count() == 0:
		# Player wins!
		if next_level == "":
			get_tree().change_scene(main_scene)
		else:
			get_tree().change_scene("res://levels/" + next_level +".tscn")
	if Input.is_action_pressed("game_quit"):
		# Quit game!
		get_tree().change_scene(main_scene)
	if Input.is_action_pressed("game_pause"):
		# Pause game
		pause.visible = true
		get_tree().set_pause(true)
