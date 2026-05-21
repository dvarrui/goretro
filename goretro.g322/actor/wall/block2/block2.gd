extends StaticBody2D

export var type = "red"
var life = 1
var hits = 0

onready var effect_hit = $effect/size
onready var effect_shine = $effect/shine
onready var timer = $timer
onready var sprite = $sprite

func _ready():
	if type == "grey":
		life = 3
	sprite.texture = load("res://actor/wall/block/" + type + ".png")

	# Conectar la señal del temporizador por código
	timer.connect("timeout", self, "_on_timer_timeout")
	_init_random_wait()

func _init_random_wait():
	timer.wait_time = rand_range(3.0, 30.0)
	timer.start()

func _on_timer_timeout():
	run_shine_effect()
	_init_random_wait()

func run_shine_effect():
	# El brillo consiste en llevar el modulate a un color más claro (blanco intenso)
	var color_normal = Color(1, 1, 1, 1)
	var color_brillo = Color(2, 2, 2, 1) # Valores mayores a 1 crean un efecto de "glow"
	
	# Animación de ida (0.2 segundos)
	effect_shine.interpolate_property(sprite, "modulate",
		color_normal, color_brillo, 0.2,
		Tween.TRANS_SINE, Tween.EASE_OUT)
	
	# Animación de vuelta (0.2 segundos) con retraso
	effect_shine.interpolate_property(sprite, "modulate",
		color_brillo, color_normal, 0.2,
		Tween.TRANS_SINE, Tween.EASE_IN, 0.2)
		
	effect_shine.start()

func hit():
	hits += 1 
	run_effect_hit()
	if hits >= life: 
		# Esperar un instante para que se vea el efecto antes de borrarlo
		yield(effect_hit, "tween_all_completed")
		queue_free()

func run_effect_hit():
	var scale1 = sprite.scale
	var scale2 = scale1 * 1.1
	# Efecto de escala (Impacto)
	effect_hit.interpolate_property(sprite, "scale",
		scale1, scale2, 0.05,
		Tween.TRANS_QUAD, Tween.EASE_OUT)
	
	effect_hit.interpolate_property(sprite, "scale",
		scale2, scale1, 0.05,
		Tween.TRANS_QUAD, Tween.EASE_IN, 0.1) # El 0.1 final es el retraso (delay)
		
	effect_hit.start()
