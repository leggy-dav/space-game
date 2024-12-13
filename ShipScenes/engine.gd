extends Area2D

class_name EnginePart

@export_category("Engine Info")
@export var thrust_power: float = 20.0
@export var turn_power: float = 20.0

@export_category("General Part Info")
@export var structural_integrety: float = 100.0 # ship health

@export var self_packed_scene: PackedScene

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
