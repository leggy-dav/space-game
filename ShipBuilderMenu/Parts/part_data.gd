extends Resource

class_name PartData


enum PART_TYPES  {
	HULL,
	ENGINE,
	UTILITY,
	WEAPONS,
	SHIELDS
}


@export var name: String = ""
@export_multiline var description: String = ""
@export var part_type: PART_TYPES
@export var cost: float = 0.0
@export var icon: Texture
@export var part_scene: PackedScene


func is_hull() -> bool:
	return part_type == PART_TYPES.HULL

func is_engine() -> bool:
	return part_type == PART_TYPES.ENGINE

func is_utility() -> bool:
	return part_type == PART_TYPES.UTILITY

func is_weapon() -> bool:
	return part_type == PART_TYPES.WEAPONS

func is_shield() -> bool:
	return part_type == PART_TYPES.SHIELDS
