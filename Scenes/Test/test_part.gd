extends Node2D

@onready var weapon_obj_00: WeaponPart = $WeaponObj00

signal fire_weapon()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	weapon_obj_00.attach_fire_signal(fire_weapon)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	#print(event)
	
	if event is InputEventMouseButton \
			and event.button_index == MOUSE_BUTTON_LEFT \
			and event.is_pressed():
		fire_weapon.emit()
