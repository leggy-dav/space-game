extends RigidBody2D


class_name AsteroidBase

@export_category("Base Stats")
@export var health: float = 100
@export var value: float = 100.0

@export_category("Astroid Properties")
@export var scale_override: float = 1.0

signal astroid_destroyed(value: float)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func damage_asteroid(damage: float) -> void:
	health -= damage
	if health <= 0:
		astroid_destroyed.emit(value)
		queue_free()
