extends "../../hitbox_abstract_chain_move.gd"

func init_vars_and_hb_time():
	anim = "attack1_1"
	move_duration = 1.5
	timer = $Timer
	hitbox_node = $hitbox
	before_hitbox_timer = $before_hitbox
	during_hitbox_timer = $duration_hitbox
	hitbox_active_from_sec = 0.3
	hitbox_active_time_sec = 0.6
	next_chain_a1 = $dennis_cmr_a1_2

func hibox_entered(body):
	print("Body % entered attack1_1" % body)