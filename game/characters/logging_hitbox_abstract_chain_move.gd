extends "hitbox_abstract_chain_move.gd"

var logged_move = false

func perform_enemy_hit(enemy_node):
	.perform_enemy_hit(enemy_node)
	if (not logged_move):
		print("anim %s move hit enemy %s" % [anim, enemy_node])
		logged_move = true
		
func reset_move_vars():
	.reset_move_vars()
	print("%s reset vars" % anim)
	logged_move = false
	
func activate_hitbox():
	.activate_hitbox()
	print("%s activate hitbox" % anim)
		
func deactivate_hitbox():
	.deactivate_hitbox()
	print("%s deactivate hitbox" % anim)
	
func begin(animator):
	.begin(animator)
	print("%s begin" % anim)
	
func reset_move_timers():
	.reset_move_timers()
	print("%s reset timers" % anim)

func _on_pre_transition_part_end():
	._on_pre_transition_part_end()
	print("%s pre trans end" % anim)
	
func _on_move_time_end():
	._on_move_time_end()
	print("%s move end" % anim)