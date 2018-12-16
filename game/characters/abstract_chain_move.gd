extends Node2D

var is_performing = false #is the move being performed right now
var next_valid_actions = ["attack1", "attack2"]

#dynamic atomic variables
var selected_next_action = "" #next pressed action to begin after this one is over
var anim = "" #animation to play during the move
var move_duration = 1.0 #actual time it takes to complete the move animation
var next_move_transition_margin = 0.0 #how much time before move is over can we transition into next one

#dynamic node references
var char_root #character root node
var next_chain_a1 #next chain member on attack1, node
var next_chain_a2 #next chain member on attack2, node
var pre_transition_timer #timer type for timeout of combo part pre-transition
var post_transition_timer #timer type for time left before combo times out but while transition still possible
var char_animator #animator cached after mov started (to pass along)


#internal var, for script logic, no need to init
var half_move_duration 
var ok_to_switch_move = false

#combo finish signal
signal combo_over

func _ready():
	init_move_vars()
	pre_transition_timer.wait_time = move_duration - next_move_transition_margin
	pre_transition_timer.one_shot = true
	pre_transition_timer.stop()
	pre_transition_timer.connect("timeout", self, "_on_pre_transition_part_end")
	if (next_move_transition_margin > 0):
		post_transition_timer.wait_time = next_move_transition_margin
		post_transition_timer.one_shot = true
		post_transition_timer.stop()
		post_transition_timer.connect("timeout", self, "_on_move_time_end")
	half_move_duration = move_duration / 2

func _process(delta):
	
	var remaining_move_time = pre_transition_timer.time_left + post_transition_timer.time_left
	
	#while the move is hapening we can try set which move comes next
	#after at least half of it is done for input buffer
	if (is_performing and remaining_move_time <= half_move_duration):
		for action in next_valid_actions:
			if Input.is_action_just_pressed(action):
				selected_next_action = action
	if (ok_to_switch_move):
		var move_to_begin = null
		if (selected_next_action == "attack1" && next_chain_a1 != null):
			move_to_begin = next_chain_a1
		elif (selected_next_action == "attack2" && next_chain_a2 != null):
			move_to_begin = next_chain_a2
		if (move_to_begin != null):
			reset_move_vars()
			move_to_begin.begin(char_animator)
	pass

#starts combo move sequence. 
#all combo moves need to have this method 
#(and will if inhertinig from this script)
func begin(animator):
	char_animator = animator
	pre_transition_timer.start()
	is_performing = true
	animator.play(anim)

#child scripts need to override 
#this and set initial move params
func init_move_vars():
	pass
	
func set_char(character_node):
	char_root = character_node
	connect("combo_over", char_root, "_finish_combo")
	if next_chain_a1 != null:
		next_chain_a1.set_char(character_node)
	if next_chain_a2 != null:
		next_chain_a2.set_char(character_node)


func reset_move_vars():
	is_performing = false
	ok_to_switch_move = false
	reset_move_timers()
	
func reset_move_timers():
	pre_transition_timer.stop()
	post_transition_timer.stop()

func _on_pre_transition_part_end():
	#stop move timers
	pre_transition_timer.stop()
	post_transition_timer.start()
	
	#try continue selected attack chain
	ok_to_switch_move = true
	pass


func _on_move_time_end():
	#reset all move vars
	reset_move_vars()
	
	#none selected or selected not available - signal end of combo
	emit_signal("combo_over")
	
	#clear selected move action after move
	selected_next_action = ""
	pass
