extends Node

const Z_COEF = sin(deg2rad(45))

func y2z(y):
	return y * Z_COEF

func z2y(z):
	return z / Z_COEF


func _ready():
	print("Global functions y2z and z2y loaded...")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
