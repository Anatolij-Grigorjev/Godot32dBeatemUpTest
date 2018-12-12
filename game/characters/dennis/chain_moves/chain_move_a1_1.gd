extends "../../hitbox_abstract_chain_move.gd"

func init_vars_and_hb_time():
	anim = "attack1_1"
	move_duration = 1.5
	timer = $Timer
	before_hitbox_timer = $before_hitbox
	during_hitbox_timer = $duration_hitbox
	hitbox_active_from_sec = 0.3
	hitbox_active_time_sec = 0.6
	next_chain_a1 = $dennis_cmr_a1_2
	hitbox_rect_size = Vector2(58, 40)
	hitbox_rect_offset = Vector2(-7, -18)
	z_radius = 15
	
#func perform_enemy_hit(enemy_node):
#	print("attack1_1 hit %s" % enemy_node)
#	pass