extends Sprite

func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		get_tree().change_scene_to( preload("res://PlayArea.tscn") )
