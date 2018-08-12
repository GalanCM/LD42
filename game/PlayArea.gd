extends Node2D

var current_area = 1_600_000
var cannon_density = 0.15

var allow_new_cannons = false

func _ready():
	yield( get_tree().create_timer(1), "timeout" )
	rand_seed( OS.get_unix_time() )
	randomize()
	create_space()
	
func _physics_process(delta):
	if allow_new_cannons and len( get_tree().get_nodes_in_group("Enemies") ) <= 0:
		create_space()

func create_space():
	allow_new_cannons = false
	var new_dimensions = Vector2( sqrt(current_area), sqrt(current_area) )
	var aspect_ratios = [ [5,4], [4,3], [3,2], [11,8], [16,10], [5,3], [16,9], [2,1] ]
	
	while true:
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
			aspect_ratios.erase(aspect_ratio)
		
	var padding = Vector2(1920 - new_dimensions.x, 1080 - new_dimensions.y)
	padding.x = floor( rand_range(0, padding.x) )
	padding.y = floor( rand_range(0, padding.y) )
	
	$LeftWall.target = padding.x
	$RightWall.target = padding.x + new_dimensions.x
	$TopWall.target = padding.y
	$BottomWall.target = padding.y + new_dimensions.y
	
	current_area *= 0.9
	
	create_cannons(new_dimensions, padding)
	
func create_cannons(dimensions, padding):
	var cannon_count = floor(dimensions.x * dimensions.y / 4096 / ( 100 * cannon_density ) )
	var grid_size = Vector2( floor(dimensions.x / 64), floor(dimensions.y / 64) )
	var cannon_locations = []
	
	for cannon_num in range(0, cannon_count):
		while true:
			var location = Vector2( randi() % int(grid_size.x), randi() % int(grid_size.y) )
			if not location in cannon_locations and location.distance_to( Vector2(grid_size.x/2, grid_size.y) ) > grid_size.x/2:
				cannon_locations.append( location )
				
				var new_cannon = preload("res://Enemies/LaserCannon.tscn").instance()
				new_cannon.position.x = location.x * 64 + padding.x
				new_cannon.position.y = location.y * 64 + padding.y
				
				if location.y < location.x and location.y < grid_size.x - location.x:
					pass
				elif location.x < location.y:
					new_cannon.rotate( -PI / 2 )
				elif grid_size.x - location.x < location.y:
					new_cannon.rotate( PI / 2 )
					
				
					
				Game.get_unique_node("CannonLayer").add_child( new_cannon )
				break
				
	allow_new_cannons = true
	cannon_density *= 0.8
