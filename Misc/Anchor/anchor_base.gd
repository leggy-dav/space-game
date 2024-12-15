extends Node2D

class_name AnchorBase

@export var anchor_points: Array[AnchorPoint]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in get_children():
		if child is AnchorPoint:
			print('Added Anchor Points : ', child.name)
			anchor_points.append(child)
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
