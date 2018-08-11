extends KinematicBody2D

const MOVEMENT_SPEED = 360

var velocity_modifier = Vector2()

func _physics_process(delta):
	var motion = velocity_modifier
	
	if Input.is_action_pressed("Up"):
		motion.y += -1
	if Input.is_action_pressed("Down"):
		motion.y += 1
	if Input.is_action_pressed("Left"):
		motion.x += -1
	if Input.is_action_pressed("Right"):
		motion.x += 1
		
	move_and_slide(motion * 540)

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
	
func push( force ):
#	print(force)
	velocity_modifier += force / 4