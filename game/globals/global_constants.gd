extends Node

## GAME
const Z_COEF = sin(deg2rad(45))

## LAYERS
const LAYERS_HERO_GROUND = 0
const LAYERS_HERO_AIR = 1
const LAYERS_STATIC_BG = 2

func _ready():
	print("Loaded global constants C!")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
