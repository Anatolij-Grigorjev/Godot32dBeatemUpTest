extends "hitbox_abstract_chain_move.gd"

var logged_move = false

func perform_enemy_hit(enemy_node):
	.perform_enemy_hit(enemy_node)
	if (not logged_move):
		print("anim %s move hit enemy %s" % [anim, enemy_node])
		logged_move = true
		
func reset_move_vars():
	.reset_move_vars()
	logged_move = false