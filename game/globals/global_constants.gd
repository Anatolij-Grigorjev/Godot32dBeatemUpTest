extends Node

## GAME
const Z_COEF = sin(deg2rad(45))
const KNOCK_2_FALL_COEF = 0.01
const GRAVITY = 98.5
const PLAYER_GROUP = "player_chars"
const ONSCREEN_ENEMIES_GROUP = "onscreen_enemies"

## LAYERS
const LAYERS_HERO_GROUND = 0
const LAYERS_HERO_AIR = 1
const LAYERS_STATIC_BG = 2
const LAYERS_ENEMY_GROUND = 3
const LAYERS_ENEMY_AIR = 4

const DATETIME_FORMAT = "%s.%s.%s %s:%s:%s"


func _ready():
	print("Loaded global constants node C!")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
