extends Label

var char_root
var current_z = 0

func _ready():
	char_root = self.get_parent()
	current_z = F.y2z(char_root.global_position.y)
	update_text()

	
func update_text():
	text = "Z: %s" % current_z
	if (char_root.is_stunned):
		text += " (stunned)"
		

func _physics_process(delta):
	var z = F.y2z(char_root.global_position.y)
	if z != current_z:
		current_z = z
	update_text()
