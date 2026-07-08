extends CanvasLayer

var cont = 4
var mode = 0
var screen_size = Vector2(600, 600)
var shaders = []
export var state = "normal"
var params = [
	[0, 0, 150, 600],
	[150, 0, 300, 600],
	[300, 0, 450, 600],
	[450, 0, 600, 600]
]

func _ready():
	shaders.append($crt)
	shaders.append($gray)
	shaders.append($green)
	shaders.append($gameboy)
	reset_shaders()

func reset_shaders():
	state = "normal"
	for shader in shaders:
		shader.visible = false
		shader.margin_left = 0
		shader.margin_top = 0
		shader.margin_right = screen_size.x
		shader.margin_bottom = screen_size.y

func change():
	cont +=1
	mode = cont % (shaders.size() + 1)

	reset_shaders()
	if mode < shaders.size():
		shaders[mode].visible = true
		state = shaders[mode].name

func change_panel():
	if state == "normal":
		state = "panel"

		params.shuffle()
		for i in [0, 1, 2, 3]:
			shaders[i].visible = true
			shaders[i].margin_left = params[i][0]
			shaders[i].margin_top = params[i][1]
			shaders[i].margin_right = params[i][2]
			shaders[i].margin_bottom = params[i][3]
	else:
		state = "normal"
		reset_shaders()

func _process(delta):
	if Input.is_action_just_pressed("screen_shader"):
		self.change()
	if Input.is_action_just_pressed("screen_panel"):
		self.change_panel()
	# self.update_shaders()

func update_shaders():
	if $gray.visible:
		# Usamos OS.get_ticks_msec() o una variable acumulativa para el tiempo
		var time_value = OS.get_ticks_msec() / 1000.0
		$gray.material.set_shader_param("time", time_value)
