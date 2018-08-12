extends Area2D

func _physics_process(delta):
	translate( Vector2(0, -810) * delta )
	
	var player = Game.get_unique_node("Player")
	if player == null:
		queue_free()
	for collider in get_overlapping_bodies():
		if collider != player and collider.has_method("take_damage"):
			collider.take_damage(1)
			
			queue_free()
	
	if position.y < -100:
		queue_free()
