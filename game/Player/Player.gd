extends KinematicBody2D

const MOVEMENT_SPEED = 360

const MAX_HEALTH = 5.0
var health = MAX_HEALTH

const MAX_STAMINA = 3
var stamina = MAX_STAMINA

var velocity_modifier = Vector2()

var bullet_cooled = true
var dodge = null

var invulnerable = false

func _physics_process(delta):
	if not invulnerable:
		health = min(health + 0.1 * delta, MAX_HEALTH)
	if $StaminaTimer.time_left < 0.00001 and stamina < MAX_STAMINA:
		stamina += (3.0/5) * delta
	var motion = Vector2()
	
	if dodge == null:
		if Input.is_action_pressed("Up"):
			motion.y += -1
		if Input.is_action_pressed("Down"):
			motion.y += 1
		if Input.is_action_pressed("Left"):
			motion.x += -1
		if Input.is_action_pressed("Right"):
			motion.x += 1
			
		if Input.is_action_just_pressed("Dodge") and stamina > 0:
			dodge = motion * 5
			stamina = max( stamina-1.0001, 0 )
			$StaminaTimer.start()
			$DodgeParticles.emitting = true
			
			yield(get_tree().create_timer(0.2), "timeout")
			dodge = null
	else:
		dodge *= 0.9
		motion = dodge
		
	move_and_slide( (motion + velocity_modifier) * 540)

	var FRICTION = 5 * delta
	if velocity_modifier.x < FRICTION and velocity_modifier.x > -FRICTION:
		velocity_modifier.x = 0
	else:
		if velocity_modifier.x > 0:
			velocity_modifier.x -= FRICTION
		else:
			velocity_modifier.x += FRICTION
	if velocity_modifier.y < FRICTION and velocity_modifier.y > -FRICTION:
		velocity_modifier.y = 0
	else:
		if velocity_modifier.y > 0:
			velocity_modifier.y -= FRICTION
		else:
			velocity_modifier.y += FRICTION
	
	if bullet_cooled and Input.is_action_pressed("Fire"):
		var bullet = preload("res://Player/Bullet.tscn").instance()
		bullet.global_position = global_position
		
		Game.get_unique_node("BulletLayer").add_child( bullet )
		
		$ShotPlayer.play()
		
		bullet_cooled = false
		yield(get_tree().create_timer(0.15), "timeout")
		bullet_cooled = true
	
func push( force ):
	velocity_modifier += force / 4
	var dodge = null
	
func take_damage(amount):
	if invulnerable:
		return
		
	health -= amount
	
	Game.get_unique_node("Camera").get_node("AnimationPlayer").play("Shake")
	
	invulnerable = true
	if health > 0:
		$AnimationPlayer.play("TakeDamage")
		yield($AnimationPlayer, "animation_finished")
		invulnerable = false
		
	else:
		$AnimationPlayer.play("Death")
		
		yield($AnimationPlayer, "animation_finished")
		get_node("/root").add_child( load("res://Erased.tscn").instance() )
		queue_free()
	