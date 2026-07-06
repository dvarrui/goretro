extends Node2D

onready var bomb = $margin/amin
onready var timer = $timer
export var next_level = "retro"

func _ready():
	timer.start()
	get_tree().set_pause(false)


func _process(delta):
	if Input.is_action_just_pressed("game_new"):
		start_new_game()
	if Input.is_action_just_pressed("game_quit"):
		close_game()

func start_new_game():
	Points.reset_current_score()
	get_tree().change_scene("res://levels/" + next_level + ".tscn")

func close_game():
	get_tree().quit()

func _on_start_pressed():
	start_new_game()

func _on_quit_pressed():
	close_game()


func _on_timer_timeout():
	if 	bomb.animation == "move":
		bomb.play("default")
	else:
		bomb.play("move")
	timer.start()
