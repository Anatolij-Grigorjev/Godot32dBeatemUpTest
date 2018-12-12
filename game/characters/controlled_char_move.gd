extends "char_move.gd"

onready var anim = $anim
var current_anim = ""

var is_attacking = false

var combo_start

func init_vals():
	speed = 50.5
	peak_jump_height = 67.8
	jump_strength = -212.7
	max_jump_ascend_time = 0.7
	ground_layer = C.LAYERS_HERO_GROUND
	air_layer = C.LAYERS_HERO_AIR
	G.PLAYER_NODE = self
	siding_change_speed = 5
	sprite = $sprite
	combo_start = $dennis_cmr_a1_2
	combo_start.set_char(self)
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
		
func _physics_process(delta):
	if (not is_attacking):
		#Combo-ing
		if Input.is_action_just_pressed("attack1"):
			is_attacking = true
			combo_start.begin(anim)
		
		._physics_process(delta)
		var new_anim = "idle"
		if (not is_jumping):
			if (not is_attacking):
				var impulse = velocity.length_squared()
				if (impulse > 0.01):
					new_anim = "walk"
			else:
				#TODO: ground attacking anim, 
				#handled by current attack node
				pass
		else:
			#TODO: air animations
			pass
		
		#resolved anim
		if (new_anim != current_anim):
			current_anim = new_anim
			anim.play(current_anim)
		
		
func _finish_combo():
	is_attacking = false
	anim.play(current_anim)
	
func adjust_velocity_siding():
	if (velocity.x < -siding_change_speed):
		sprite.scale.x = -1
		combo_start.scale.x = -1
	if (velocity.x > siding_change_speed):
		sprite.scale.x = 1
		combo_start.scale.x = 1
	