extends "comboing_char_move.gd"

var post_combo_cooldown_timer
var allowed_combo = true

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
	post_combo_cooldown_timer = $post_combo_cooldown
	anim = $anim
	combo_start = $dennis_cmr_a1_1
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
		
func get_attack_input():
	if Input.is_action_just_pressed("attack1") and allowed_combo:
		is_attacking = true
		F.logf("%s start combo", name)
		combo_start.begin(anim)
		
func _finish_combo():
	._finish_combo()
	F.logf("%s finish combo", name)
	allowed_combo = false
	post_combo_cooldown_timer.start()
	
func _on_combo_cooldown_finished():
	F.logf("%s finish combo cooldown", name)
	allowed_combo = true
	post_combo_cooldown_timer.stop()
