extends "../../abstract_chain_move.gd"

func init_move_vars():
	anim = "attack1_1"
	move_duration = 1.8
	set_shot_time(1.25)
	timer = $Timer
