extends CharacterBody2D


var rotation_direction: float = 0.0
var rotational_acceleration: float = 10 # get value from engins

var weapons_array: Array[Weapon]

func _ready() -> void:
	
	tether_children($".", "")
	
	pass

func tether_children(parent, padding):
	for child in parent.get_children():
		if child is Engine:
			print(padding, "engine : ", child)
		if child is Weapon:
			print(padding, "Weapon : ", child)
			weapons_array.append(child)
		if child is Hull:
			print(padding, "Hull : ", child)
		if child is Shield:
			print(padding, "Shield : ", child)
		tether_children(child, padding + "\t")
		

func _physics_process(delta: float) -> void:
	# Add the gravity.

	rotation_direction = Input.get_axis("player_rotate_left", "player_rotate_right")
	if rotation_direction:
		var rotational_velocity = rotation_direction * delta * rotational_acceleration
		rotate(rotational_velocity)

	#move_and_slide()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fire_weapon_01"):
		for weapon in weapons_array:
			weapon.fire_weapon()
	
	if event.is_action_released("fire_weapon_01"):
		for weapon in weapons_array:
			weapon.cease_fire()
