extends KinematicBody2D

export (float) var speed = 0
export (float) var peak_jump_height = 0
export (float) var jump_strength = 0
export (float) var max_jump_ascend_time = 0
export (float) var siding_change_speed = 0

var ground_layer
var air_layer
var sprite

var is_jumping = false
var is_ascending = false
var is_stunned = false
var last_prejump_y = 0
var current_jump_ascend_time = 0


var velocity = Vector2()

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
	global_position.y = last_prejump_y
	F.swap_layer_bit(self, air_layer, ground_layer)
	
	
func start_jump():
	velocity.y += jump_strength
	current_jump_ascend_time = max_jump_ascend_time
	is_jumping = true
	is_ascending = true
	F.swap_layer_bit(self, ground_layer, air_layer)
	last_prejump_y = global_position.y
	
func adjust_velocity_siding():
	if (velocity.x < -siding_change_speed):
		sprite.scale.x = -1
	if (velocity.x > siding_change_speed):
		sprite.scale.x = 1
		
func _on_fixed_process(delta):
	if (not is_stunned):
		get_move_input()
	adjust_velocity_siding()
	if (is_jumping):
		#finish jump
		if (global_position.y >= last_prejump_y):
			finish_jump()
		else:
			if (is_ascending):
				current_jump_ascend_time -= delta
				if (current_jump_ascend_time <= 0 or 
					last_prejump_y - global_position.y >= peak_jump_height):
					is_ascending = false
			velocity.y += jump_strength if is_ascending else C.GRAVITY
	else:
		get_jump_input()
	move_and_slide(velocity)

#this method is final, shouldnt be overriden
func _physics_process(delta):
	_on_fixed_process(delta)
	
#process the movement portion of being hit
# velocity describes intensity and direction of hit
# knockdown intensity describes ability of hit to make character fall
func receive_hit_movement(hit_velocity = Vector2(), hit_knockdown_intensity = 0):
	F.logf("%s stunned and hit for velocity %s", [self, hit_velocity])
	velocity = hit_velocity
	is_stunned = true
	pass  