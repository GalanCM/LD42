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

	velocity_modifier.x = max( velocity_modifier.x - 5 * delta, 0)
	velocity_modifier.y = max( velocity_modifier.y - 5 * delta, 0)
	
func push( force ):
	velocity_modifier = force / 5