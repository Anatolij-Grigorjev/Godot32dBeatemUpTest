extends Node

# CONSTANTS
const Z_COEF = sin(deg2rad(45))

## LAYERS
const LAYERS_HERO_GROUND = 0
const LAYERS_HERO_AIR = 1
const LAYERS_STATIC_BG = 2



func y2z(y):
	return y * Z_COEF

func z2y(z):
	return z / Z_COEF

func swap_layer_bit(node, from_layer, to_layer):
	var temp_layer_bit = node.get_collision_layer_bit(from_layer)
	node.set_collision_layer_bit(from_layer, node.get_collision_layer_bit(to_layer))
	node.set_collision_layer_bit(to_layer, temp_layer_bit)

func _ready():
	print("Global functions y2z and z2y loaded...")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
