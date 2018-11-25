extends KinematicBody2D

export (float) var speed = 200.5
export (float) var PEAK_JUMP_HEIGHT = 67.8
export (float) var JUMP_STRENGTH = -212.7
export (float) var MAX_JUMP_ASCEND_TIME = 0.7

var is_jumping = false
var is_ascending = false
var last_jump_y = 0
var current_jump_ascend_time = 0

var GRAVITY = 98.5

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
	current_jump_ascend_time = MAX_JUMP_ASCEND_TIME
	is_jumping = true
	is_ascending = true
	F.swap_layer_bit(self, C.LAYERS_HERO_GROUND, C.LAYERS_HERO_AIR)
	last_jump_y = position.y

func _physics_process(delta):
	get_move_input()
	if (is_jumping):
		#finish jump
		if (position.y >= last_jump_y):
			current_jump_ascend_time = 0
			is_jumping = false
			F.swap_layer_bit(self, C.LAYERS_HERO_AIR, C.LAYERS_HERO_GROUND)
		else:
			if (is_ascending):
				current_jump_ascend_time -= delta
				if (current_jump_ascend_time <= 0 or 
					last_jump_y - position.y >= PEAK_JUMP_HEIGHT):
					is_ascending = false
			velocity.y += JUMP_STRENGTH if is_ascending else GRAVITY
	
	else:
		get_jump_input()
	move_and_slide(velocity)