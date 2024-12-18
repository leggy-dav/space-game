extends Node2D

class_name ConnectionBase

@export var connection_points: Array[ConnectionPoint]

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is ConnectionPoint:
			connection_points.append(child)
	pass # Replace with function body.


func get_connection_point_by_name(name: String) -> ConnectionPoint:
	for cp in connection_points:
		if cp.name == name:
			return cp
	
	print('Cannot Find Connection Point "', name, '"')
	return null


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
