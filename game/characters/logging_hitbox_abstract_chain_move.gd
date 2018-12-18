extends "hitbox_abstract_chain_move.gd"

var logged_hits = {}

func perform_enemy_hit(enemy_node):
	.perform_enemy_hit(enemy_node)
	if (not logged_hits.has(enemy_node)):
		F.logf("%s %s hit enemy %s", [char_root.name, anim, enemy_node])
		logged_hits[enemy_node] = true
		
func reset_move_vars():
	F.logf("%s %s reset vars", [char_root.name, anim])
	.reset_move_vars()
	logged_hits.clear()
	
func activate_hitbox():
	F.logf("%s %s activate hitbox", [char_root.name, anim])
	.activate_hitbox()
		
func deactivate_hitbox():
	F.logf("%s %s deactivate hitbox", [char_root.name, anim])
	.deactivate_hitbox()
	
func begin(animator):
	F.logf("%s %s begin", [char_root.name, anim])
	.begin(animator)
	
func reset_move_timers():
	F.logf("%s %s reset timers", [char_root.name, anim])
	.reset_move_timers()

func _on_pre_transition_part_end():
	F.logf("%s %s pre trans end", [char_root.name, anim])
	._on_pre_transition_part_end()
	
func _on_move_time_end():
	F.logf("%s %s end", [char_root.name, anim])
	._on_move_time_end()