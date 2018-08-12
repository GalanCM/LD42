extends Node

func _physics_process(delta):
	var player = Game.get_unique_node("Player")
	if player == null:
		return
		
	if $RayCast2D.is_colliding():
		player.take_damage(2)
		