extends Control

func _ready():
	set_process_input(false)

	yield($AnimationPlayer, "animation_finished")
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("Exit"):
		get_tree().quit()
	elif event.is_action_pressed("Fire"):
		get_tree().reload_current_scene()
		queue_free()
