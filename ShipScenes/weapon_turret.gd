extends Node2D

class_name TurretPart

@export_category("Weapon Info")
@export var rate_of_fire: float = 1.0
@export var projectile: PackedScene
@export var projectile_spawn_point: Vector2

@export_category("General Part Info")
@export var structural_integrety: float = 100.0 # ship health


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
