extends CharacterBody2D

class_name PlayerBase

@export_category("On Ready Toggles")
@export var on_ready_build_ship: bool = false
@export var use_mouse_aim: bool = true

@export_category("Ship Stats")
@export var rotation_speed: float = 1.0
@export var ship_scale: float = 2.0

var has_cockpit: bool = false
var has_engines: bool = false
var engine_power: float = 0.0
var ship_mass: float = 0.0
var weapons_list: Array[WeaponPart]
var shields_list: Array[ShieldPart]


const SHIP_BUILD_MANAGER = preload("res://Managers/ShipBuilder/ship_build_manager.tres")

var ship_target_point: Vector2 = Vector2.ZERO
var radian_offset: float = (PI / 2) # this allows for the ship to point "up" when rotating


signal fire_balistic_weapons()
signal stop_balistic_weapons()


func _ready() -> void:
	if on_ready_build_ship:
		var ship_save_dict: Dictionary = SHIP_BUILD_MANAGER.get_ship_save()
		
		SHIP_BUILD_MANAGER.build_ship(ship_save_dict, self)
		#SHIP_BUILD_MANAGER.build_ship()
		
		#print("get_used_rect() : ", get_used_rect())
		
		# scale up the ship so it looks pretty
		for child in get_children():
			child.scale = Vector2.ONE * ship_scale
		
		
		# get list of parts
		# add signal connections and activate parts
		# get states from parts for ship health, ship speed
		scan_ship_data()
		teather_weapons()


func _physics_process(delta: float) -> void:

	rotate_to_target(delta)
	pass

func _input(event: InputEvent) -> void:
	
	if event is InputEventKey \
			and event.keycode == KEY_ESCAPE \
			and event.is_pressed():
		get_tree().change_scene_to_file("res://Scenes/MainMenu/main_menu.tscn")
	
	if has_cockpit:
		
		if event is InputEventMouseMotion:
			ship_target_point = event.position

		if event.is_action_pressed("fire_ballistic_weapons"):
			print('Pressed Fire')
			fire_balistic_weapons.emit()
		
		if  event.is_action_released("fire_ballistic_weapons"):
			stop_balistic_weapons.emit()

	


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
		var angle_diff = wrapf(target_angle - rotation, -PI, PI)
		
		# apply a constant step towards the target angle
		if abs(angle_diff) > rotation_speed * delta:
			rotation += sign(angle_diff) * rotation_speed * delta
		else:
			rotation = target_angle
		
		#rotation = lerp_angle(rotation, target_angle, rotation_speed * delta)  


###############################################################################
#     ███████ ██   ██ ██ ██████  
#     ██      ██   ██ ██ ██   ██ 
#     ███████ ███████ ██ ██████  
#          ██ ██   ██ ██ ██      
#     ███████ ██   ██ ██ ██      
################################################################################

# search ship parts
# engine_power: float = 0.0
# mass: float = 0.0
# guns: Array[WeaponPart]
# shields: Array[WeaponPart]
func scan_ship_data() -> void:
	
	# check base part
	for child in get_children():
		if child is PartObject:
			#print(child.name, '\t', child.mass)
			ship_mass += child.mass
			
			# if hull
			# if util
			# if cockpit
			if child is CockpitPart:
				has_cockpit = true
			# if weapon
			# if shield
			if child is EnginePart:
				has_engines = true
			
			_scan_child(child)
	
	print()
	print('Ship Mass : ', ship_mass)
	print('Engine Power : ', engine_power)
	rotation_speed = engine_power - (ship_mass * 0.1)
	if has_engines:
		if rotation_speed < 0.5:
			rotation_speed = 0.5
	else:
		rotation_speed = 0.0
	print('Rotation Speed : ', rotation_speed)
	


func _scan_child(base: PartObject, indent: String = '\t') -> void:
	for child in base.get_children():
		
		if child is ConnectionBase:
			
			for conn_p in child.connection_points:
				var attached_part = conn_p.get_attached_part()
				if attached_part:
					#print(indent, attached_part.name)
					ship_mass += attached_part.mass
					
					if attached_part is EnginePart:
						has_engines = true
						engine_power += attached_part.power
						
					if attached_part is CockpitPart:
						has_cockpit = true
					
					if attached_part is WeaponPart:
						weapons_list.append(attached_part)
					
					if attached_part is ShieldPart:
						shields_list.append(attached_part)
					
					_scan_child(attached_part, indent+"\t")


###############################################################################
#      ██     ██ ███████  █████  ██████   ██████  ███    ██ ███████ 
#      ██     ██ ██      ██   ██ ██   ██ ██    ██ ████   ██ ██      
#      ██  █  ██ █████   ███████ ██████  ██    ██ ██ ██  ██ ███████ 
#      ██ ███ ██ ██      ██   ██ ██      ██    ██ ██  ██ ██      ██ 
#       ███ ███  ███████ ██   ██ ██       ██████  ██   ████ ███████ 
###############################################################################
															 
															 

# teather guns
func teather_weapons() -> void:
	## Teather Guns to User Interface
	for weapon in weapons_list:
		var firing_mechanism = weapon.get_weapon_part()
		print('Firing Mechanism : ', firing_mechanism)
		# balistic weapon setup
		if firing_mechanism is BallisticCannon:
			weapon.attach_fire_signal(fire_balistic_weapons)
			
			if firing_mechanism.is_full_auto():
				weapon.attach_cease_fire_signal(stop_balistic_weapons)
		
		# missle weapon setup
		
		# plasma weapon setup
		
		# we'll want different setups because there could be like different properties
	
