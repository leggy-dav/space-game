extends Node2D

@export_category("Astroids")
@export var astroid_scene: PackedScene
@export var random_scale_min: float = 1.0
@export var random_scale_max: float = 2.0

var destroyed_asteroid_count: int = 0
var velocity_range_min: float = 50
var velocity_range_max: float = 150

@onready var asteroid_spawn_timer: Timer = $AsteroidSpawnTimer

var player_funds: float = 0
@onready var funds_label: Label = $UserInterface/FundsPanel/FundsLabel


const PLAYER_MANAGER = preload("res://Managers/Player/player_manager.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Start Funds : ", PLAYER_MANAGER.money)
	
	player_funds = PLAYER_MANAGER.get_funds()
	pass # Replace with function body.
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


###############################################################################
#     █████  ███████ ████████ ███████ ██████   ██████  ██ ██████  
#    ██   ██ ██         ██    ██      ██   ██ ██    ██ ██ ██   ██ 
#    ███████ ███████    ██    █████   ██████  ██    ██ ██ ██   ██ 
#    ██   ██      ██    ██    ██      ██   ██ ██    ██ ██ ██   ██ 
#    ██   ██ ███████    ██    ███████ ██   ██  ██████  ██ ██████  
###############################################################################


func _on_astroid_spawn_timer_timeout() -> void:
	var asteroid = astroid_scene.instantiate()
	
	if asteroid is AsteroidBase:
		asteroid.astroid_destroyed.connect(player_destroid_asteroid)
		pass
		#astroid.astroid_destroyed.connect(update_funds)
	
	var asteroid_spawn_location = $AstroidPath/AstroidSpawnLocation
	asteroid_spawn_location.progress_ratio = randf()
	
	var direction = asteroid_spawn_location.rotation + PI / 2
	
	asteroid.position = asteroid_spawn_location.position
	
	direction += randf_range(-PI / 4, PI / 4)
	asteroid.rotation = direction
	
	var velocity = Vector2(randf_range(velocity_range_min, velocity_range_max), 0.0)
	asteroid.linear_velocity = velocity.rotated(direction)
	
	# add random scale
	var scale_size = randf_range(random_scale_min, random_scale_max)
	
	# add random rotation speed 
	var rotation_speed = randf_range(-360, 360)
	
	add_child(asteroid)
	asteroid.apply_scaling(scale_size)
	asteroid.set_angular_velocity(deg_to_rad(rotation_speed)) 
	
	pass # Replace with function body.

###############################################################################
#                                   ██    ██ ██████████
#                                   ██    ██     ██ 
#                                   ██    ██     ██ 
#                                   ██    ██     ██ 
#                                    ██████  ██████████ 
###############################################################################

func player_destroid_asteroid(asteroid_value: float) -> void:
	destroyed_asteroid_count += 1
	
	if (destroyed_asteroid_count % 5) == 0:
		print('FASTER !')
		var new_spawn_time = asteroid_spawn_timer.wait_time - 0.25
		if new_spawn_time < 0.25:
			new_spawn_time = 0.25
		asteroid_spawn_timer.wait_time = new_spawn_time
		velocity_range_max += 10
		pass
	
	player_funds += asteroid_value
	update_funds_label()

func update_funds_label() -> void:
	funds_label.text = '$%.2f' % player_funds
