extends Node

## GAME
const Z_COEF = sin(deg2rad(45))
const GRAVITY = 98.5
const PLAYER_GROUP = "player_chars"

## LAYERS
const LAYERS_HERO_GROUND = 0
const LAYERS_HERO_AIR = 1
const LAYERS_STATIC_BG = 2


func _ready():
	print("Loaded global constants node C!")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
