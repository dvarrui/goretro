extends RigidBody2D

onready var sound_block = $sound/block
onready var sound_wall = $sound/wall

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	# Check collisions
	for body in get_colliding_bodies():
		if body.is_in_group("block"):
			sound_block.play()
			body.hit()
		else:
			sound_wall.play()

func _on_visibility_screen_exited():
	get_tree().change_scene("res://ui/title.tscn")
