extends Node2D

onready var level = $level
onready var score = $score
onready var high = $high

func _ready():
	level.text = ""

func _process(delta):
	score.text = "SCORE " + str(Points.current_score)
	high.text = "HIGH " + str(Points.high_score)

func set_level_name(name):
	level.text = "LEVEL " + name
