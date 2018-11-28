extends "char_move.gd"

const DISTANCE_TO_PLAYER = 100

func init_vals():
	speed = 200.5
	peak_jump_height = 67.8
	jump_strength = -212.7
	max_jump_ascend_time = 0.7
	ground_layer = C.LAYERS_ENEMY_GROUND
	air_layer = C.LAYErS_ENEMY_AIR
	pass

func get_move_input():
	velocity = Vector2()
	var my_pos = global_position
	var player_pos = G.PLAYER_NODE.global_position
	var distance = my_pos.distance_to(player_pos)
	#do we need to move?
	if (distance > DISTANCE_TO_PLAYER):
		velocity.x = 1 if player_pos.x > my_pos.x else -1
		velocity.y = 1 if player_pos.y > my_pos.y else -1
	velocity = velocity.normalized() * speed
	
func get_jump_input():
	if (Input.is_action_just_pressed('jump')): 
		start_jump()