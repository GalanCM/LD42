extends KinematicBody2D

var health = 2

func _ready():
	set_physics_process(false)
	yield(get_tree().create_timer(randi() % 3 * 2), "timeout")
	
	$"../AnimationPlayer".play("Intro")
	yield($"../AnimationPlayer", "animation_finished")
	set_physics_process(true)
	
	yield(get_tree().create_timer(0.1), "timeout")
	
	while true:
		yield(get_tree().create_timer(2), "timeout")
		
		fire()
		yield($Laser/AnimationPlayer, "animation_finished")
		

func _physics_process(delta):
	var player = Game.get_unique_node("Player")
	if player == null:
		return
		
	look_at( player.global_position )
	rotate(-PI/2)
	
func fire():
	$Laser/AnimationPlayer.play("Fire")
	
func take_damage(amount):
	health -= amount
	$AnimationPlayer.play("Shake")
	
	if health <= 0:
		get_parent().queue_free()