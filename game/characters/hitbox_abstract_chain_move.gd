extends "abstract_chain_move.gd"


var hitbox_rect_size = Vector2()
var hitbox_rect_offset = Vector2()
var z_radius = 0
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
		before_hitbox_timer.stop()
		before_hitbox_timer.connect("timeout", self, "activate_hitbox")
	
	#if no end timer, stop at move end
	if (hitbox_active_time_sec != null and during_hitbox_timer != null):
		during_hitbox_timer.wait_time = hitbox_active_time_sec
		during_hitbox_timer.one_shot = true
		during_hitbox_timer.stop()
		during_hitbox_timer.connect("timeout", self, "deactivate_hitbox")
	

#overrid this for vars setting
func init_vars_and_hb_time():
	pass
	
func begin(char_animator):
	.begin(char_animator)
	if (before_hitbox_timer != null):
		before_hitbox_timer.start()
	else:
		activate_hitbox()
	
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
		
	
func _process(delta):
	var char_z
	if (hitbox_enabled and char_root.is_attacking):
		var onscreen_enemies = get_tree().get_nodes_in_group(C.ONSCREEN_ENEMIES_GROUP)
		if (not onscreen_enemies.empty()):
			char_z = F.char_actual_z(char_root)
		for enemy in onscreen_enemies:
			#skip enemies that cant be hit (due to receiving hit, dying, etc)
			if (not enemy.can_be_hit()):
				continue
			var enemy_z = F.char_actual_z(enemy)

			if (F.val_in_target_radius(char_z, enemy_z, z_radius)):
				#check hit
				var actual_hit_rect = Rect2(
					self.global_position + hitbox_rect_offset,
					hitbox_rect_size
				)

				if (actual_hit_rect.has_point(enemy.global_position)):
					perform_enemy_hit(enemy)
				
	#do move input checks for future moves
	._process(delta)

#return true or false if hit connected (enemy wasnt invulnerable)
func perform_enemy_hit(enemy_node):
	pass

