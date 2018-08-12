extends Sprite

func _ready():
	AudioServer.set_bus_mute(1, true)

func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		
		get_tree().change_scene_to( preload("res://PlayArea.tscn") )
		MusicPlayer.get_node("AnimationPlayer").play("FadeIn")
		AudioServer.set_bus_mute(1, false)
