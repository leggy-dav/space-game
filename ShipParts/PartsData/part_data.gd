extends Resource

class_name PartData

enum PART_TYPES  {
	COCKPIT,
	HULL,
	ENGINE,
	UTILITY,
	WEAPONS,
	SHIELDS
}

@export var part_id: String = ""

@export var name: String = ""
@export_multiline var description: String = ""
@export var cost: float = 0.0
@export var part_type: PART_TYPES

@export_category("Part References")
@export var icon: Texture
@export var packed_scene: PackedScene


func is_hull() -> bool:
	return part_type == PART_TYPES.HULL

func is_cockpit() -> bool:
	return part_type == PART_TYPES.COCKPIT

func is_engine() -> bool:
	return part_type == PART_TYPES.ENGINE

func is_utility() -> bool:
	return part_type == PART_TYPES.UTILITY

func is_weapon() -> bool:
	return part_type == PART_TYPES.WEAPONS

func is_shield() -> bool:
	return part_type == PART_TYPES.SHIELDS
