extends StaticBody2D

export var color = "red"
var life = 1
var hits = 0

onready var sprite = $sprite/red
onready var effect = $sprite/effect

func _ready():
	if color == "red":
		sprite = $sprite/red
		sprite.visible = true
	elif color == "orange":
		sprite = $sprite/orange
		sprite.visible = true
	elif color == "yellow":
		sprite = $sprite/yellow
		sprite.visible = true
	elif color == "green":
		sprite = $sprite/green
		sprite.visible = true
	elif color == "blue":
		sprite = $sprite/blue
		sprite.visible = true
	else:
		sprite = $sprite/purple
		sprite.visible = true

func play_effect():
	var color_normal = Color(1, 1, 1, 1)
	var color_brillo = Color(250, 250, 250, 1)
	
	effect.interpolate_property(sprite, "modulate",
		color_normal, color_brillo, 0.1,
		Tween.TRANS_SINE, Tween.EASE_OUT)
	
	# Animación de vuelta (0.2 segundos) con retraso
	effect.interpolate_property(sprite, "modulate",
		color_brillo, color_normal, 0.1,
		Tween.TRANS_SINE, Tween.EASE_IN, 0.1)
		
	effect.start()

func hit():
	hits += 1 
	play_effect()
	if hits >= life: 
		# Esperar un instante para que se vea el efecto antes de borrarlo
		yield(effect, "tween_all_completed")
		queue_free()

