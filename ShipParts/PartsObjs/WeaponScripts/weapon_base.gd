extends Node2D


class_name WeaponBase

@export_category("Weapon Base")
@export var full_auto: bool = false
@export var autonomous: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func is_full_auto() -> bool:
	return full_auto


func is_autonomous() -> bool:
	return autonomous
