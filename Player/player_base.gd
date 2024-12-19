extends CharacterBody2D

class_name PlayerBase

@export_category("On Ready Toggles")
@export var on_ready_build_ship: bool = false
@export var use_mouse_aim: bool = true

@export_category("Ship Stats")
@export var rotation_speed: float = 1.0

const SHIP_BUILD_MANAGER = preload("res://ShipBuilder/ship_build_manager.tres")

var ship_target_point: Vector2 = Vector2.ONE
var radian_offset: float = (PI / 2) # this allows for the ship to point "up" when rotating

func _ready() -> void:
	if on_ready_build_ship:
		var ship_save_dict: Dictionary = SHIP_BUILD_MANAGER.get_ship_save()
		
		SHIP_BUILD_MANAGER.build_ship(ship_save_dict, self)
		#SHIP_BUILD_MANAGER.build_ship()
	
		# scale up the ship so it looks pretty
		for child in get_children():
			child.scale = Vector2.ONE * 2
		
		# get list of parts
		# add signal connections and activate parts
		# get states from parts for ship health, ship speed


func _physics_process(delta: float) -> void:
	# Add the gravity.

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	#move_and_slide()
	#if ship_target_point:
		#var target_angle = self.po
	rotate_to_target(delta)
	#print(ship_target_point, global_position)
	pass

func _input(event: InputEvent) -> void:
	
	if event is InputEventMouseMotion:
		ship_target_point = event.position
	
	if event is InputEventKey \
			and event.keycode == KEY_ESCAPE \
			and event.is_pressed():
		get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")

###############################################################################
#  ███    ███  ██████  ██    ██ ███████ ███    ███ ███████ ███    ██ ████████ 
#  ████  ████ ██    ██ ██    ██ ██      ████  ████ ██      ████   ██    ██    
#  ██ ████ ██ ██    ██ ██    ██ █████   ██ ████ ██ █████   ██ ██  ██    ██    
#  ██  ██  ██ ██    ██  ██  ██  ██      ██  ██  ██ ██      ██  ██ ██    ██    
#  ██      ██  ██████    ████   ███████ ██      ██ ███████ ██   ████    ██    
###############################################################################

func rotate_to_target(delta: float) -> void:
	if ship_target_point:
		var target_angle = global_position.angle_to_point(ship_target_point) + radian_offset
		
		# calculate the shortest path to rotate
		var angle_difference = wrapf(target_angle - rotation, -PI, PI)
		
		# apply a constant step towards the target angle
		if abs(angle_difference) > rotation_speed * delta:
			rotation += sign(angle_difference) * rotation_speed * delta
		else:
			rotation = target_angle
		
		#rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)  
