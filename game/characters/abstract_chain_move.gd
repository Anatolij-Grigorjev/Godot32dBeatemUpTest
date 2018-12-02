extends Node2D

var is_performing = false #is the move being performed right now
var hitbox_enabled = false #register attacks or not on this hitbox
var next_valid_actions = ["attack1", "attack2"]

#dynamic atomic variables
var selected_next_action = "" #next pressed action to begin after this one is over
var anim = "" #animation to play during the move
var move_duration = 1.0 #actual time it takes to complete the move

#dynamic node references
var char_root #character root node
var hitbox #hitbox rectangle for signals
var next_chain_a1 #next chain member on attack1, node
var next_chain_a2 #next chain member on attack2, node
var timer #timer type for timeout of combo move
var char_animator #animator cached after mov started (to pass along)

#combo finish signal
signal combo_over

func _ready():
	init_move_vars()
	hitbox_enabled = false
	timer.wait_time = move_duration
	timer.one_shot = true
	timer.stop()
	timer.connect("timeout", self, "_on_move_time_end")
	pass

func _process(delta):
	#while the move is hapening we can try set which move comes next
	#after at least half of it is done for input buffer
	if (is_performing and timer.time_left <= move_duration / 2):
		for action in next_valid_actions:
			if Input.is_action_just_pressed(action):
				selected_next_action = action
	pass

#starts combo move sequence. 
#all combo moves need to have this method 
#(and will if inhertinig from this script)
func begin(animator):
	char_animator = animator
	timer.start()
	is_performing = true
	animator.play(anim)
	hitbox_enabled = true

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
	hitbox_enabled = false
	timer.stop()

func _on_move_time_end():
	
	reset_move_vars()
	
	#try continue selected attack chain
	if (selected_next_action == "attack1" && next_chain_a1 != null):
		next_chain_a1.begin(char_animator)
	elif (selected_next_action == "attack2" && next_chain_a2 != null):
		next_chain_a2.begin(char_animator)
	else:
		#none selected or selected not available - signal end of combo
		emit_signal("combo_over")
	pass
