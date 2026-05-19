extends StaticBody2D

export var type = "red"
var life = 1
var hits = 0
onready var effect = get_node("effect")

func _ready():
	if type == "grey":
		life = 3
	$sprite.texture = load("res://actor/wall/block/" + type + ".png")

func hit2():
	hits += 1
	if hits >= life:
		queue_free()

func hit():
	hits += 1 
	hit_effect()
	if hits >= life: 
		# Esperar un instante para que se vea el efecto antes de borrarlo
		yield(effect, "tween_all_completed")
		queue_free()

func hit_effect():
	# Efecto de escala (Impacto)
	# Animamos la escala de (1,1) a (1.2, 1.2) en 0.1 segundos
	effect.interpolate_property($sprite, "scale",
		Vector2(1, 1), Vector2(1.2, 1.2), 0.05,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	
	# Animamos la vuelta a la normalidad de (1.2, 1.2) a (1,1)
	effect.interpolate_property($sprite, "scale",
		Vector2(1.2, 1.2), Vector2(1, 1), 0.05,
		Tween.TRANS_QUAD, Tween.EASE_IN, 0.1) # El 0.1 final es el retraso (delay)
		
	effect.start()
