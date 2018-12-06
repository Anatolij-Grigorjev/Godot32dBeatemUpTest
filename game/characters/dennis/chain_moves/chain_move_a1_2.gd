extends "../../hitbox_abstract_chain_move.gd"

func init_move_vars():
	anim = "attack1_2"
	move_duration = 1.5
	timer = $Timer
	hitbox_node = $hitbox
	before_hitbox_timer = $before_hitbox
	during_hitbox_timer = $duration_hitbox
	hitbox_active_from_sec = 0.3
	hitbox_active_time_sec = 0.6
