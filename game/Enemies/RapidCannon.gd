extends KinematicBody2D

var health = 3
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
		for i in range(0,3):
			fire()

			yield(get_tree().create_timer(0.3), "timeout")

		yield(get_tree().create_timer(3), "timeout")

func _physics_process(delta):
	var player = Game.get_unique_node("Player")
	if player == null:
		return

	look_at( player.global_position )
	rotate(-PI/2)

func fire():
	if Game.get_unique_node("Player") == null:
		return
	var bullet = preload("res://Enemies/Bullet.tscn").instance()
	bullet.global_transform = global_transform
	Game.get_unique_node("BulletLayer").add_child(bullet)
	
	var rapid_player = Game.get_unique_node("RapidPlayer")
	rapid_player.play()

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