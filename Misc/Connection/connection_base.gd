extends Node2D

class_name ConnectionBase

@export var connection_points: Array[ConnectionPoint]

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_connection_points()
	pass # Replace with function body.


func get_connection_point_by_name(conn_name: String) -> ConnectionPoint:
	for cp in connection_points:
		if cp.name == conn_name:
			return cp
	
	print('Cannot Find Connection Point "', name, '"')
	return null


func get_connection_points() -> void:
	if connection_points.size() > 0:
		connection_points.clear()
	for child in get_children():
		if child is ConnectionPoint:
			connection_points.append(child)


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
