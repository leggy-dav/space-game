extends PanelContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func set_part_info(part_data: PartData):
	if part_data.is_hull():
		return
	
	
	
	
	pass


func clear_part_info():
	pass
