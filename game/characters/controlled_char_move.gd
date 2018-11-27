extends "char_move.gd"

func init_vals():
	speed = 200.5
	peak_jump_height = 67.8
	jump_strength = -212.7
	max_jump_ascend_time = 0.7
	ground_layer = C.LAYERS_HERO_GROUND
	air_layer = C.LAYERS_HERO_AIR
	G.PLAYER_NODE = self
	pass

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