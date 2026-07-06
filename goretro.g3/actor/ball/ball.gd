extends RigidBody2D

onready var ball = "."
onready var sound_block = $sound/block
onready var sound_wall = $sound/wall
onready var sound_gameover = $sound/gameover

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	for body in get_colliding_bodies():
		if body.is_in_group("block"):
			sound_block.pitch_scale = rand_range(1, 1.2)
			sound_block.play()
			body.hit()
			
			# var f = self.linear_velocity.length()
			# if f < 250:
			#	apply_central_impulse(Vector2(100, 100))
			# else:
			# 	apply_central_impulse(Vector2(0, 5))
		else:
			sound_wall.pitch_scale = rand_range(0.8, 1.2)
			sound_wall.play()

func _on_visibility_screen_exited():
	sound_gameover.play()
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().change_scene("res://ui/title.tscn")
