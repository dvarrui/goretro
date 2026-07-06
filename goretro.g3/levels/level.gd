extends Node2D

export var next_level = "game_over"
onready var sound = $ui/sound
onready var level = $ui/level
onready var pause = $ui/pause
onready var score = $ui/score
onready var high = $ui/high

func _ready():
	level.text = "LEVEL " + name
	sound.play()

func _process(_delta):
	if get_node("wall").get_child_count() == 0:
		# Player wins!
		get_tree().change_scene("res://levels/" + next_level +".tscn")
	if Input.is_action_pressed("game_quit"):
		# Quit game!
		get_tree().change_scene("res://ui/title.tscn")
	if Input.is_action_pressed("game_pause"):
		# Pause game
		pause.visible = true
		get_tree().set_pause(true)
	self.update_ui()

func update_ui():
	score.text = "SCORE " + str(Points.current_score)
	high.text = "HIGH " + str(Points.high_score)
