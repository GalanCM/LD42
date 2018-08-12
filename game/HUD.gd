extends Control

func _ready():
	$HealthBar.set_as_toplevel(true)
	$StaminaBar1.set_as_toplevel(true)
	$StaminaBar2.set_as_toplevel(true)
	$StaminaBar3.set_as_toplevel(true)
	

func _process(delta):
	var player = Game.get_unique_node("Player")
	if player == null:
		return
		
	$HealthBar.value = player.health / player.MAX_HEALTH
	
	if player.stamina < 1:
		$StaminaBar1.value = player.stamina
		$StaminaBar2.value = 0
		$StaminaBar3.value = 0
	elif player.stamina < 2:
		$StaminaBar1.value = 1
		$StaminaBar2.value = fmod(player.stamina, 1.0)
		$StaminaBar3.value = 0
	elif player.stamina < 3:
		$StaminaBar1.value = 1
		$StaminaBar2.value = 1
		$StaminaBar3.value = fmod(player.stamina, 2.0)
	else:
		$StaminaBar1.value = 1
		$StaminaBar2.value = 1
		$StaminaBar3.value = 1
