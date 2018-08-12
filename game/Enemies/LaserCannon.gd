extends KinematicBody2D

var health = 2
var spawn_delay = 0

func _ready():
	set_physics_process(false)
	$CollisionShape2D.disabled = true
	yield(get_tree().create_timer(spawn_delay * 2), "timeout")
	
	$"../AnimationPlayer".play("Intro")
	yield($"../AnimationPlayer", "animation_finished")
	set_physics_process(true)
	$CollisionShape2D.disabled = false
	
	yield(get_tree().create_timer(0.1), "timeout")
	
	while true:
		yield(get_tree().create_timer(1), "timeout")
		
		fire()
		yield(get_tree().create_timer(1.5), "timeout")
		set_physics_process(false)
		
		yield($Laser/AnimationPlayer, "animation_finished")
		yield(get_tree().create_timer(1), "timeout")
		set_physics_process(true)
		

func _physics_process(delta):
	var player = Game.get_unique_node("Player")
	if player == null:
		return
		
	look_at( player.global_position )
	rotate(-PI/2)
	
func fire():
	if Game.get_unique_node("Player") == null:
		return
	$Laser/AnimationPlayer.play("Fire")
	
	yield(get_tree().create_timer(2), "timeout")
	var laser_player = Game.get_unique_node("LaserPlayer")
	laser_player.play()
	
func take_damage(amount):
	health -= amount
	$AnimationPlayer.play("Shake")
	$"../HitPlayer".play()
	
	if health <= 0:
		$"../AnimationPlayer".play("Death")
		$CollisionShape2D.disabled = true
		$"../BlockCollision".disabled = true
		
		yield($"../AnimationPlayer", "animation_finished")
		get_parent().queue_free()