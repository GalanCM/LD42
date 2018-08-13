extends Node

var tutorial_shown = false

func get_unique_node(name):
	var group = get_tree().get_nodes_in_group(name)
	
	if len(group) == 0:
		return null
	else:
		if len(group) > 1:
			print("WARNING: More than one unique node " + name + "." )
		return group[0]
		
func _input(event):
	if event.is_action_pressed("Exit"):
		get_tree().quit()