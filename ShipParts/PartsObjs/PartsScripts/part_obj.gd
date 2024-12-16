extends Area2D

class_name PartObject

@export var part_id: String = ""

## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass



func get_connection_base() -> ConnectionBase:
	for child in get_children():
		if child is ConnectionBase:
			return child
	return null


func get_anchor_base() -> AnchorBase:
	for child in get_children():
		if child is AnchorBase:
			return child
	return null


func remove_anchors() -> void:
	for child in get_children():
		if child is AnchorBase:
			child.queue_free()
			return


func remove_connections() -> void:
	for child in get_children():
		if child is ConnectionBase:
			child.queue_free()
			return
