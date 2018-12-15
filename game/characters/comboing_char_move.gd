extends "char_move.gd"

var current_anim = ""

var is_attacking = false

###NODE VARS
var combo_start
var anim

func get_attack_input():
	pass
		
func _on_fixed_process(delta):
	if (not is_attacking):
		#Combo-ing
		get_attack_input()
		var new_anim = "idle"
		._on_fixed_process(delta)
		if (not is_jumping):
			if (not is_attacking):
				var impulse = velocity.length_squared()
				if (impulse > 0.01):
					new_anim = "walk"
			else:
				#TODO: ground attacking anim, 
				#handled by current attack node
				pass
		else:
			#TODO: air animations
			pass
		
		#resolved anim
		if (new_anim != current_anim):
			current_anim = new_anim
			anim.play(current_anim)
		
		
func _finish_combo():
	is_attacking = false
	anim.play(current_anim)
	
func adjust_velocity_siding():
	if (velocity.x < -siding_change_speed):
		sprite.scale.x = -1
		combo_start.scale.x = -1
	if (velocity.x > siding_change_speed):
		sprite.scale.x = 1
		combo_start.scale.x = 1
