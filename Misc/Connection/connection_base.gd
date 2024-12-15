extends Node2D

class_name ConnectionBase

@export var connection_points: Array[ConnectionPoint]

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is ConnectionPoint:
			print('Added Connection Point : ', child.name)
			connection_points.append(child)
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
