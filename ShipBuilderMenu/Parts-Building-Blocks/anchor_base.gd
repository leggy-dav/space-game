extends Node2D

var anchor_points: Array[Area2D]
var anchor_index: int = 0

var active: bool = false



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	for child in get_children():
		anchor_points.append(child)
	pass # Replace with function body.
	
	print('Anchor Base Size: ', anchor_points.size())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if active:
		pass
	pass

func is_active() -> bool:
	return active

func activate() -> void:
	active = true

func deactivate() -> void:
	active = false


func get_current_anchor_point() -> Area2D:
	return anchor_points[anchor_index]


func set_next_anchor_point() -> Area2D:
	anchor_index += 1
	if anchor_index >= anchor_points.size():
		anchor_index = 0
	print('new anchor index: ', anchor_index)
	return anchor_points[anchor_index]
