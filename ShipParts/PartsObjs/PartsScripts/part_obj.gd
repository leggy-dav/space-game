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

func hide_connection_base() -> void:
	for child in get_children(true):
		print('\tHide CP : part : ', child.name )
		if child is ConnectionBase:
			child.hide()


func show_connection_base() -> void:
	for child in get_children(true):
		if child is ConnectionBase:
			child.show()


func get_current_anchor():
	for child in get_children(true):
		if child is AnchorBase:
			return child.get_curr_anchor()
			pass
	return null


func get_connection_points():
	for child in get_children(true):
		if child is ConnectionBase:
			return child.connection_points
	return null


func set_next_anchor() -> bool:
	for child in get_children(true):
		if child is AnchorBase:
			child.set_next_anchor()
			return true
	return false


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
