extends "char_move.gd"

export (float) var speed = 200.5
export (float) var PEAK_JUMP_HEIGHT = 67.8
export (float) var JUMP_STRENGTH = -212.7
export (float) var MAX_JUMP_ASCEND_TIME = 0.7


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

func _physics_process(delta):
	._physics_process(delta)