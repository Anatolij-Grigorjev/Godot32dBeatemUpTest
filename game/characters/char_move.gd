extends KinematicBody2D

export (float) var speed = 0
export (float) var peak_jump_height = 0
export (float) var jump_strength = 0
export (float) var max_jump_ascend_time = 0
export (float) var siding_change_speed = 0

var ground_layer
var air_layer
var sprite

## STATE FLAGS
var is_jumping = false
var is_ascending = false
var is_stunned = false
var is_falling = false

var last_preair_y = 0
var current_jump_ascend_time = 0
var current_fall_ascend_time = 0
var current_stun_time = 0

var velocity = Vector2()

func change_layer_ground2air():
	F.swap_layer_bit(self, ground_layer, air_layer)
	
func change_layer_air2ground():
	F.swap_layer_bit(self, air_layer, ground_layer)
	
func start_fall(fall_ascend_time):
	is_falling = true
	is_stunned = true
	current_fall_ascend_time = fall_ascend_time
	last_preair_y = global_position.y
	change_layer_ground2air()
	
func start_stunned(stun_time):
	is_stunned = true
	current_stun_time = stun_time

func _ready():
	init_vals()
	pass
	
func init_vals():
	pass

func get_move_input():
	pass
	
func get_jump_input():
	pass
	
func can_be_hit():
	return false
	
func finish_jump():
	current_jump_ascend_time = 0
	is_jumping = false
	global_position.y = last_preair_y
	change_layer_air2ground()
	
func finish_fall():
	current_fall_ascend_time = 0
	is_falling = false
	global_position.y = last_preair_y
	is_stunned = false
	change_layer_air2ground()
	
func finish_stun():
	is_stunned = false
	current_stun_time = 0.0
	
func start_jump():
	velocity.y += jump_strength
	current_jump_ascend_time = max_jump_ascend_time
	is_jumping = true
	is_ascending = true
	change_layer_ground2air()
	last_preair_y = global_position.y
	
func adjust_velocity_siding():
	if (velocity.x < -siding_change_speed):
		sprite.scale.x = -1
	if (velocity.x > siding_change_speed):
		sprite.scale.x = 1
		
func process_jumping(delta):
	#finish jump
	if (global_position.y >= last_preair_y):
		finish_jump()
	else:
		if (is_ascending):
			current_jump_ascend_time -= delta
			if (current_jump_ascend_time <= 0 or 
				last_preair_y - global_position.y >= peak_jump_height):
				is_ascending = false
		velocity.y += jump_strength if is_ascending else C.GRAVITY
		
func process_falling(delta):
	if (global_position.y > last_preair_y):
		finish_fall()
	else:
		var fall_ascending = current_fall_ascend_time > 0
		if (fall_ascending):
			current_fall_ascend_time -= delta
		else:
			velocity.y += C.GRAVITY
			
		
func _on_fixed_process(delta):
	if (not is_stunned):
		get_move_input()
		if (not is_jumping):
			get_jump_input()
		adjust_velocity_siding()
		if (is_jumping):
			process_jumping(delta)
	if (is_falling):
		process_falling(delta)
	if (current_stun_time > 0):
		current_stun_time -= delta
	else:
		finish_stun()
	move_and_slide(velocity)

#this method is final, shouldnt be overriden
func _physics_process(delta):
	_on_fixed_process(delta)
	
#process the movement portion of being hit
# props.hit_knockdown_velocity describes intensity and direction of hit knowckdown
# props.hit_stun_time describe time of stun 
func receive_hit_movement(hit_props = {}):
	F.logf("%s hit with props %s", [self, hit_props])
	F.assert_dict_props(hit_props, ["hit_knockdown_velocity", "hit_stun_time"])
	pass  