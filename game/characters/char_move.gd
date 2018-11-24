extends KinematicBody2D

export (int) var speed = 200
export (int) var PEAK_JUMP_HEIGHT = 75
export (int) var JUMP_STRENGTH = -200

var is_jumping = false
var is_ascending = false
var last_jump_y = 0

var GRAVITY = 98

var velocity = Vector2()

func get_move_input():
	velocity = Vector2()
	if Input.is_action_pressed('move_right'):
		velocity.x += 1
	if Input.is_action_pressed('move_left'):
		velocity.x -= 1
	if (!is_jumping):
		if Input.is_action_pressed('move_down'):
			velocity.y += 1
		if Input.is_action_pressed('move_up'):
			velocity.y -= 1
	velocity = velocity.normalized() * speed
	
func get_jump_input():
	if (Input.is_action_just_pressed('jump')): 
		start_jump()
	
func start_jump():
	velocity.y += JUMP_STRENGTH
	is_jumping = true
	is_ascending = true
	G.swap_layer_bit(self, G.LAYERS_HERO_GROUND, G.LAYERS_HERO_AIR)
	last_jump_y = position.y

func _physics_process(delta):
	get_move_input()
	if (is_jumping):
		#finish jump
		if (position.y >= last_jump_y):
			is_jumping = false
			G.swap_layer_bit(self, G.LAYERS_HERO_AIR, G.LAYERS_HERO_GROUND)
		else:
			velocity.y += JUMP_STRENGTH if is_ascending else GRAVITY
			if (last_jump_y - position.y >= PEAK_JUMP_HEIGHT):
				is_ascending = false
	
	else:
		get_jump_input()
	move_and_slide(velocity)