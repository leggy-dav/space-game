extends Area2D

class_name ConnectionPoint


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


signal connection_point_mouse_entered(Area2D)
signal connection_point_mouse_exited()

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func _on_mouse_entered() -> void:
	connection_point_mouse_entered.emit(self)
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	connection_point_mouse_exited.emit()
	pass # Replace with function body.
