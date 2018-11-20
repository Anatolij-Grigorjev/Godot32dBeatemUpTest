extends Node2D

onready var character_node = $dennis
onready var feet_node = $feet

var FEET_OFFSET = Vector2(0, 30)

func _ready():

	pass

func _process(delta):
	feet_node.position = character_node.position + FEET_OFFSET
