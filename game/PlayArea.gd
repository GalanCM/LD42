extends Node2D

var current_area = 300_000

func _ready():
	yield( get_tree().create_timer(1), "timeout" )
	rand_seed( OS.get_unix_time() )
	randomize()
	create_space()

func create_space():
	var new_dimensions = Vector2( sqrt(current_area), sqrt(current_area) )
	var aspect_ratios = [ [5,4], [4,3], [3,2], [11,8], [16,10], [5,3], [16,9], [2,1] ]
	
	while true:
		print(len(aspect_ratios))
		var aspect_ratio = aspect_ratios[randi() % aspect_ratios.size()]
		new_dimensions.y = sqrt( current_area / (aspect_ratio[0] /  aspect_ratio[1]) )
		new_dimensions.x = current_area / new_dimensions.y
		
		if new_dimensions.x < 1080:
			if randi() % 5 < 3:
				var swap_temp = new_dimensions.y
				new_dimensions.y = new_dimensions.x
				new_dimensions.x = swap_temp
		
		if new_dimensions.x < 1920 and new_dimensions.y < 1080:
			break
		else:
			print(aspect_ratio, new_dimensions)
			aspect_ratios.erase(aspect_ratio)
		
	var padding = Vector2(1920 - new_dimensions.x, 1080 - new_dimensions.y)
	padding.x = floor( rand_range(0, padding.x) )
	padding.y = floor( rand_range(0, padding.y) )
	
	$LeftWall.target = padding.x
	$RightWall.target = padding.x + new_dimensions.x
	$TopWall.target = padding.y
	$BottomWall.target = padding.y + new_dimensions.y
	
	current_area -= 100_000
	
func create_cannons(area):
	pass