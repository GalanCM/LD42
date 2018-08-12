extends Node

func get_unique_node(name):
	var group = get_tree().get_nodes_in_group(name)
	
	if len(group) == 0:
		return null
	else:
		if len(group) > 1:
			print("WARNING: More than one unique node " + name + "." )
		return group[0]