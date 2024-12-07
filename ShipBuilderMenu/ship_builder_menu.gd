extends Node2D

@onready var parts_menu: Control = $Parts_Menu
@onready var hull_anchor_point: Node2D = $Build_Area/Hull_Anchor_Point
@onready var mouse_display: PanelContainer = $MouseDisplay


var hull_part: PartData


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	parts_menu.update_grabbed_parts_display.connect(update_mouse_part_display)
	mouse_display.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func update_hull(part: PartData):
	print('Update Hull : ', part.name)
#
#
#func _on_whole_menu_area_gui_input(event: InputEvent) -> void:
	#print('Clear Selected Item')
	#if event is InputEventMouseButton \
			#and (event.button_index == MOUSE_BUTTON_RIGHT) \
			#and event.is_pressed():
		#print('Clear Selected Item')
		#pass
	#pass # Replace with function body.


#func _on_control_gui_input(event: InputEvent) -> void:
	#
	#if event is InputEventMouseButton and (event.button_index == MOUSE_BUTTON_RIGHT) and event.is_pressed():
		#print(event)
		#pass
	pass # Replace with function body.


func update_mouse_part_display(part_data: PartData) -> void:
	print('\tUpdate Part Data: ', part_data.name, "\t", part_data.is_hull())
	
	mouse_display.show()
	mouse_display.set_part_info(part_data)
	
	pass

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		
		parts_menu.clear_grabbed_part()
		mouse_display.hide()
