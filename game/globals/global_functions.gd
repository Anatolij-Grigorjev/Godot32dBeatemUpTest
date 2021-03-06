extends Node

#approximate
func y2z(y):
	return round(y * C.Z_COEF)

#approximate
func z2y(z):
	return round(z / C.Z_COEF)
	
func knockdown_intensity2fall_ascend_time(knockdown_intensity):
	return knockdown_intensity * C.KNOCK_2_FALL_COEF
	
func val_in_target_radius(val, target, radius):
	#check if value is in radius of target with a short circuit if equal
	return (
		val == target or 
		(target - radius <= val and val <= target + radius)
	)
	
#get character position z coordinate, respecting jump
#z depends on air/ground and coefficient
func char_actual_z(char_node):
	var char_position = char_node.global_position
	#take current y if character is on the ground
	#if they jump y depends on where they jumped from
	var z = y2z(
		char_position.y if not char_node.is_jumping 
		else char_node.last_prejump_y
	)
	return z
	

func swap_layer_bit(node, from_layer, to_layer):
	var temp_layer_bit = node.get_collision_layer_bit(from_layer)
	node.set_collision_layer_bit(from_layer, node.get_collision_layer_bit(to_layer))
	node.set_collision_layer_bit(to_layer, temp_layer_bit)
	
	
#log formatted
func logf(format, args_list):
	var log_statement = format % args_list
	#print log date in utc
	print("[%s UTC]: %s" % [format_date(OS.get_datetime(true)), log_statement])
	
func assert_dict_props(dict = {}, props_names = []):
	if (not dict.has_all(props_names)):
		logf("!!!ERROR!!! %s doesnt contain all props names of %s" % [dict, props_names])
	
func format_date(datetime_dict):
	return C.DATETIME_FORMAT % [
		datetime_dict.year,
		datetime_dict.month,
		datetime_dict.day,
		datetime_dict.hour,
		datetime_dict.minute,
		datetime_dict.second
	]
	

func _ready():
	print("Loaded global functions node F!")
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
