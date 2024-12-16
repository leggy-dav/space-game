extends PanelContainer

class_name PartSlot

signal slot_clicked(index: int, button: int)

@onready var texture_rect: TextureRect = $MarginContainer/TextureRect
@onready var name_label: Label = $NameLabel
@onready var cost_label: Label = $CostLabel


## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

func set_part_info(part: PartData) -> void:
	name_label.text = part.name
	cost_label.text = "$%.2f" % part.cost
	texture_rect.texture = part.icon
	

func _on_mouse_entered() -> void:
	# TODO : emit singal to display description
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	# TODO : emit singal to clear displayed description
	pass # Replace with function body.


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
	pass # Replace with function body.
