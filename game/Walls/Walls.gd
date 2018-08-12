extends KinematicBody2D

var target = 0 setget set_target

const SPEED = 960

signal move_finished

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	var position_delta = SPEED * delta
	var motion = Vector2()
	
	if name == "LeftWall" or name == "RightWall":
		if abs( target - position.x ) < position_delta:
			position.x = target
			set_physics_process(false)
			emit_signal("move_finished")
		elif position.x < target:
			motion.x += SPEED
		else:
			motion.x += -SPEED
			
	else:
		if abs( target - position.y ) < position_delta:
			position.y = target
			set_physics_process(false)
			emit_signal("move_finished")
		elif position.y < target:
			motion.y += SPEED
		else:
			motion.y += -SPEED
			
	var collision = move_and_collide(motion * delta)
	
	if collision and collision['collider'].name == "Player":
		collision['collider'].push(motion*delta)

func set_target(t):
	target = t
	set_physics_process(true)