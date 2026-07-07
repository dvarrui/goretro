extends CanvasLayer

var cont = 0
var mode = 0

func change():
	cont +=1
	mode = cont %  4
	if mode == 0:
		$crt.visible = false
		$gray.visible = false
		$green.visible = false
	elif mode == 1:
		$crt.visible = true
		$gray.visible = false
		$green.visible = false
	elif mode == 2:
		$crt.visible = false
		$gray.visible = true
		$green.visible = false
	elif mode == 3:
		$crt.visible = false
		$gray.visible = false
		$green.visible = true
