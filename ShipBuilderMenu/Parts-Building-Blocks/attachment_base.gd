extends Node2D

@export var attachment_nodes: Array[Node2D]

var active: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
	for child in get_children():
		if child is Node2D:
			#print('Node2D\t', child.name)
			attachment_nodes.append(child)
	
	for item in attachment_nodes:
		if item.has_attachment:
			item.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func remove_attachment_base():
	attachment_nodes.clear()
	queue_free()
	pass


func is_active() -> bool:
	return active

func activate() -> void:
	active = true

func deactivate() -> void:
	active = false
