extends Node2D

class_name AnchorBase

@export var anchor_points: Array[AnchorPoint]

var anchor_index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is AnchorPoint:
			print('Added Anchor Points : ', child.name)
			anchor_points.append(child)
	pass # Replace with function body.


func get_curr_anchor() -> AnchorPoint:
	return anchor_points[anchor_index]


func set_next_anchor() -> void:
	anchor_index += 1
	if anchor_index >= anchor_points.size():
		anchor_index = 0


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
