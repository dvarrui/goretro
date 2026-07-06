extends Node

var current_score = 0
var high_score = 0

# func _ready():
#	pass # Replace with function body.

func reset_current_score():
	current_score = 0

func inc_current_score(value):
	current_score += value
	if current_score > high_score:
		high_score = current_score
