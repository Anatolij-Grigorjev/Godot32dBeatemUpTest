extends KinematicBody2D

const FLOOR_NORMAL = Vector2(0, 0)
const SLOPE_SLIDE_STOP = 25.0
const MIN_ONAIR_TIME = 0.1
const WALK_SPEED_X = 150 # pixels/sec
const WALK_SPEED_Y = 50
const JUMP_SPEED = 480
const SIDING_CHANGE_SPEED = 10

var linear_vel = Vector2()
var onair_time = 0 #
var on_floor = false
var is_combo = false #is the character in the middle of a combo?

var anim=""

#cache the nodes here for fast access
onready var sprite = $sprite
#onready var combo_start = $cmr_a1_1 # first node in combo sequence
onready var animator = $animator

func _ready():
	#set the char root node on the combo chain
	#call sets character and signals for this move and 
	#passes the call down the chain
#	combo_start.set_char(self)
	pass
	

func _physics_process(delta):
	#increment counters

	onair_time += delta

	### MOVEMENT ###

	# Move and Slide
	linear_vel = move_and_slide(linear_vel, FLOOR_NORMAL, SLOPE_SLIDE_STOP)
	# Detect Floor
	if is_on_floor():
		onair_time = 0

	on_floor = onair_time < MIN_ONAIR_TIME

	### CONTROL ###

	# Horizontal Movement
	var target_speed_x = 0
	if Input.is_action_pressed("move_left"):
		target_speed_x += -1
	if Input.is_action_pressed("move_right"):
		target_speed_x +=  1

	target_speed_x *= WALK_SPEED_X
	linear_vel.x = lerp(linear_vel.x, target_speed_x, 0.1)
	
	# Vertical Movement
	var target_speed_y = 0
	if Input.is_action_pressed("move_up"):
		target_speed_y += -1
	if Input.is_action_pressed("move_down"):
		target_speed_y +=  1

	target_speed_y *= WALK_SPEED_Y
	linear_vel.y = lerp(linear_vel.y, target_speed_y, 0.1)
	
	if (not is_combo):
		#Combo-ing
#		if Input.is_action_just_pressed("attack1"):
#			is_combo = true
#			combo_start.begin(animator)
		
		# Jumping
		if on_floor and Input.is_action_just_pressed("jump"):
			linear_vel.y = -JUMP_SPEED

	### ANIMATION ###
	if (not is_combo):
		var new_anim = "idle"
	
		if on_floor:
			if linear_vel.x < -SIDING_CHANGE_SPEED:
				sprite.scale.x = -1
				new_anim = "run"
	
			if linear_vel.x > SIDING_CHANGE_SPEED:
				sprite.scale.x = 1
				new_anim = "run"
		else:
			# We want the character to immediately change facing side when the player
			# tries to change direction, during air control.
			# This allows for example the player to shoot quickly left then right.
			if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
				sprite.scale.x = -1
			if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
				sprite.scale.x = 1
	
			if linear_vel.y < 0:
				new_anim = "jumping"
			else:
				new_anim = "falling"
	
#		if new_anim != anim:
#			anim = new_anim
#			animator.play(anim)
		print(position)
		
func _finish_combo():
	is_combo = false
	#play whatever the last saved animation was
	animator.play(anim)
