extends KinematicBody2D

var health = 3

func _ready():
	set_physics_process(false)
	yield(get_tree().create_timer(randi() % 3 * 2), "timeout")

	$"../AnimationPlayer".play("Intro")
	yield($"../AnimationPlayer", "animation_finished")
	set_physics_process(true)

	yield(get_tree().create_timer(0.1), "timeout")

	while true:
		for i in range(0,3):
			fire()

			yield(get_tree().create_timer(0.3), "timeout")

		yield(get_tree().create_timer(1), "timeout")

func _physics_process(delta):
	var player = Game.get_unique_node("Player")
	if player == null:
		return

	look_at( player.global_position )
	rotate(-PI/2)

func fire():
	var bullet = preload("res://Enemies/Bullet.tscn").instance()
	bullet.global_transform = global_transform
	Game.get_unique_node("BulletLayer").add_child(bullet)

func take_damage(amount):
	health -= amount
	$AnimationPlayer.play("Shake")

	if health <= 0:
		get_parent().queue_free()