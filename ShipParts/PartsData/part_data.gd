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


@export var name: String = ""
@export_multiline var description: String = ""
@export var cost: float = 0.0
@export var part_type: PART_TYPES

@export_category("Part References")
@export var icon: Texture
@export var packed_scene: PackedScene
