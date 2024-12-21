extends PartObject

class_name WeaponPart

var weapon_part: WeaponBase



## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	for child in get_children():
		if child is WeaponBase:
			weapon_part = child
		
		# TODO: add other part options


func attach_fire_signal(sig: Signal):
	#sig.connect()
	if not weapon_part.is_autonomous():
		
		if weapon_part is BallisticCannon:
			sig.connect(weapon_part.fire)
			print('Connected : ', weapon_part)


func attach_cease_fire_signal(sig: Signal):
	#if not weapon_part.
	if not weapon_part.is_autonomous():
		if weapon_part.is_full_auto():
			
			if weapon_part is BallisticCannon:
				sig.connect(weapon_part.cease_fire)
	pass


func get_weapon_part() -> WeaponBase:
	return weapon_part
	
