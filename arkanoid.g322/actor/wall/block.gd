extends StaticBody2D

export var type = "red"
var life = 1
var hits = 0

func _ready():
	if type == "grey":
		life = 3
	$sprite.texture = load("res://actor/wall/block/" + type + ".png")

func hit():
	hits += 1
	if hits >= life:
		queue_free()
