extends Node2D

@export var attachment_nodes: Array[Node2D]

var active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	for child in get_children():
		if child is Node2D:
			if child.name.begins_with("AP_"):
				attachment_nodes.append(child)
	
	#hide_attachments()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func remove_attachment_base():
	attachment_nodes.clear()
	queue_free()
	pass
	
func hide_attachments():
	for point in attachment_nodes:
		point.deactivate()
		point.hide()


func show_attachments():
	for point in attachment_nodes:
		point.activate()
		point.show()

func hide_point(index: int):
	if index < attachment_nodes.size():
		attachment_nodes[index].hide()
	else:
		print("Cannot Hide Point! Index does not exist : ", index, " : (array size : ", attachment_nodes.size(), ")")


func get_point_index(point: Area2D) -> int:
	for index in attachment_nodes.size():
		if point.name == attachment_nodes[index].name:
			return index
	return -1


func get_nearest_point_global(pos: Vector2) -> Area2D:
	var nearest_node = null
	var nearest_dist = -1.0
	for node in attachment_nodes:
		if not nearest_node:
			nearest_node = node
			nearest_dist = pos.distance_to(node.global_position)
		else:
			var dist = pos.distance_to(node.global_position)
			if dist < nearest_dist:
				nearest_node = node
				nearest_dist = dist
	
	# incase mouse is too far away
	# like in the cases where anchor points and attachment points do not 
	# over lap 
	
	return nearest_node
		

func is_active() -> bool:
	return active

func activate() -> void:
	active = true

func deactivate() -> void:
	active = false
