extends PanelContainer

@onready var name_label: Label = $NameLabel
@onready var cost_label: Label = $CostLabel
@onready var texture_rect: TextureRect = $MarginContainer/TextureRect

signal slot_clicked(index: int, button: int)

func _ready() -> void:
	pass



func set_part_info(part: PartData) -> void:
	name_label.text = part.name
	cost_label.text = "$%.2f" % part.cost
	texture_rect.texture = part.icon
	tooltip_text = "%s" % part.description


func set_part_name(new_name: String) -> void:
	name_label.text = new_name


func set_part_cost(new_cost: float) -> void:
	cost_label.text = "$%.2f" % new_cost


func set_part_texture(texture: Texture) -> void:
	texture_rect.texture = texture


func _on_gui_input(event: InputEvent) -> void:
	
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_LEFT) \
			and event.is_pressed():
		slot_clicked.emit(get_index(), event.button_index)
		print('Part Slot Clicked: index=', get_index(), " button=", event.button_index)
	pass # Replace with function body.
