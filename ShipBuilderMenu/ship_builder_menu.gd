extends Node2D

@onready var parts_menu: Control = $Parts_Menu
@onready var hull_anchor_point: Node2D = $Hull_Anchor_Point
@onready var mouse_drag_limit: Control = $Mouse_Drag_Limit


var curr_hull_part = null
var curr_attachment_part: Node2D = null
var mouse_position: Vector2 = Vector2.ZERO
var can_drag: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	parts_menu.update_grabbed_parts_display.connect(update_mouse_part_display)
	print('Mouse_Drag_Limit Pos: ', mouse_drag_limit.position)
	print("Mouse_Drag_limit bottom: ", mouse_drag_limit.size)

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if curr_attachment_part and mouse_part_in_drag_range():
		curr_attachment_part.position = mouse_position
	pass


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

func mouse_part_in_drag_range() -> bool:
	
	if mouse_position.x < mouse_drag_limit.position.x \
			or mouse_position.x > mouse_drag_limit.position.x + mouse_drag_limit.size.x:
		return false
	
	if mouse_position.y < mouse_drag_limit.position.y \
			or mouse_position.y > mouse_drag_limit.position.y + mouse_drag_limit.size.y:
		return false
	
	return true

func update_mouse_part_display(part_data: PartData) -> void:
	print('\tUpdate Part Data: ', part_data.name, "\t", part_data.is_hull())
	
	
	if part_data.is_hull():
		print('\n\tHull_Anchor_Point : ', hull_anchor_point)
		
		
		if curr_hull_part:
			if curr_hull_part.name == part_data.name:
				return
			else:
				print('Get user confirmation that this will delete current ship build!')
				pass
			hull_anchor_point.get_child(0).queue_free()
		
		
		var hull_part = part_data.part_scene.instantiate()
		hull_anchor_point.add_child(hull_part)
		hull_part.set_scale(hull_part.get_scale() * 2)
		curr_hull_part = part_data
		
	else:
		# HANDLE A SHIP PART
		
		if curr_attachment_part:
			curr_attachment_part.queue_free()
		
		var attachment_part = part_data.part_scene.instantiate()
		add_child(attachment_part)
		attachment_part.set_scale(attachment_part.get_scale() * 2)
		attachment_part.position = mouse_drag_limit.position
		var attachment_base = attachment_part.find_child("Attachment_Base")
		if attachment_base:
			attachment_base.hide()
		curr_attachment_part = attachment_part
		
		pass
	
	pass

func _input(event: InputEvent) -> void:
	#print(event)
	if event is InputEventMouseButton \
			and (event.button_index == MOUSE_BUTTON_RIGHT) \
			and event.is_pressed():
		
		parts_menu.clear_grabbed_part()
		if curr_attachment_part:
			curr_attachment_part.queue_free()
			curr_attachment_part = null
		
	if curr_attachment_part and event is InputEventMouseMotion:
		mouse_position = event.position
		pass
