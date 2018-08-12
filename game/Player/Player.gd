extends KinematicBody2D

const MOVEMENT_SPEED = 360

var velocity_modifier = Vector2()

var bullet_cooled = true
var dodge = null

func _physics_process(delta):
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
			
		if Input.is_action_just_pressed("Dodge"):
			dodge = motion * 5
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
		
		bullet_cooled = false
		yield(get_tree().create_timer(0.15), "timeout")
		bullet_cooled = true
	
func push( force ):
	velocity_modifier += force / 4
	var dodge = null
	
func take_damage(amount):
	return
	queue_free()