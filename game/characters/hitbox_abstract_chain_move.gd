extends "abstract_chain_move.gd"


var hitbox_node
var hitbox_enabled = false

#timer boundaries
var hitbox_active_from_sec
var hitbox_active_time_sec
var before_hitbox_timer
var during_hitbox_timer


func init_move_vars():
	.init_move_vars()
	init_vars_and_hb_time()
	hitbox_enabled = false
	if (hitbox_active_from_sec != null and before_hitbox_timer != null):
		before_hitbox_timer.wait_time = hitbox_active_from_sec
		before_hitbox_timer.one_shot = true
		before_hitbox_timer.start()
		before_hitbox_timer.connect("timeout", self, "activate_hitbox")
	else:
		#if no start timer activate immediately
		activate_hitbox()
	
	#if no end timer, stop at move end
	if (hitbox_active_time_sec != null and during_hitbox_timer != null):
		during_hitbox_timer.wait_time = hitbox_active_time_sec
		during_hitbox_timer.one_shot = true
		during_hitbox_timer.stop()
		during_hitbox_timer.connect("timeout", self, "deactivate_hitbox")
	
	hitbox_node.connect("body_entered", self, "_hitbox_entered")
	

#overrid this for vars setting
func init_vars_and_hb_time():
	pass
	
func reset_move_vars():
	.reset_move_vars()
	deactivate_hitbox()

func activate_hitbox():
	hitbox_enabled = true
	if (during_hitbox_timer != null):
		during_hitbox_timer.start()
		
func deactivate_hitbox():
	hitbox_enabled = false
	if (before_hitbox_timer != null):
		before_hitbox_timer.stop()
	if (during_hitbox_timer != null):
		during_hitbox_timer.stop()
		
func _hitbox_entered(body):
	if (char_root.is_attacking):
		if (hitbox_enabled):
			hitbox_active_entered(body)
		else:
			hibox_inactive_entered(body)


func hibox_active_entered(body):
	pass
	
func hibox_inactive_entered(body):
	pass


