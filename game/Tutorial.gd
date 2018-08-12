extends Control

var step = 0
var lock = true

signal next

func _ready():
	if Game.tutorial_shown == true:
		queue_free()
		return
		
	yield(get_tree().create_timer(3), "timeout")
	$AnimationPlayer.play("ShowArrows")
	yield($AnimationPlayer, "animation_finished")
	lock = false
	
	yield(self, "next")
	$AnimationPlayer.play("ShowZ")
	yield($AnimationPlayer, "animation_finished")
	lock = false
	
	yield(self, "next")
	$AnimationPlayer.play("ShowX")
	yield($AnimationPlayer, "animation_finished")
	lock = false

func _input(event):
	if lock:
		return
	if step == 0 and (event.is_action_pressed("Up") or event.is_action_pressed("Down") or event.is_action_pressed("Left") or event.is_action_pressed("Right") ):
		step += 1
		emit_signal("next")
		$Arrows.queue_free()
	elif step == 1 and event.is_action_pressed("Fire"):
		step += 1
		emit_signal("next")
		$Z.queue_free()
	elif step == 2 and event.is_action_pressed("Dodge") and ( Input.is_action_pressed("Up") or Input.is_action_pressed("Down") or Input.is_action_pressed("Left") or Input.is_action_pressed("Right")):
		$AnimationPlayer.play("Close")
		
		yield($AnimationPlayer, "animation_finished")
		queue_free()
		Game.tutorial_shown = true
