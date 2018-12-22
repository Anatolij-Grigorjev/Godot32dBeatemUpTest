extends "../../logging_hitbox_abstract_chain_move.gd"

func init_vars_and_hb_time():
	anim = "attack1_1"
	move_duration = 1.6
	next_move_transition_margin = 0.3
	pre_transition_timer = $pre_transition_timer
	post_transition_timer = $post_transition_timer
	before_hitbox_timer = $before_hitbox
	during_hitbox_timer = $duration_hitbox
	hitbox_active_from_sec = 0.3
	hitbox_active_time_sec = 0.6
	next_chain_a1 = $dennis_cmr_a1_2
	hitbox_rect_size = Vector2(58, 40)
	hitbox_rect_offset = Vector2(-7, -18)
	z_radius = 15
	
func process_enemy_hit(enemy_node):
	.process_enemy_hit(enemy_node)
	enemy_node.receive_hit_movement(Vector2(50, -50))
	pass