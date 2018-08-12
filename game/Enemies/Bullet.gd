extends Area2D

func _physics_process(delta):
	translate( Transform2D().rotated( global_transform.get_rotation() ) * Vector2(0, 540) * delta )
	
	var player = Game.get_unique_node("Player")
	if player == null:
		return
	if overlaps_body(player):
		player.take_damage(1)
		
	if position.y > 1180:
		queue_free()