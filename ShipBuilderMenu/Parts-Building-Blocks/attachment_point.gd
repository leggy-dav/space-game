extends Node2D

@export_category("Attachment Exclude")
#@export_group("Attachment Exclude")
@export var allow_engine: bool = true
@export var allow_sheild: bool = true
@export var allow_util: bool = true
@export var allow_weapon: bool = true

@export_category("Attachment Info")
@export var has_attachment: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# TODO : add attachement nodes to array
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
