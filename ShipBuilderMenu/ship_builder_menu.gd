extends Node2D

@onready var parts_menu: Control = $Parts_Menu
@onready var hull_anchor_point: Node2D = $Hull_Anchor_Point
@onready var mouse_drag_limit: Control = $Mouse_Drag_Limit

@export var part_up_scale: float = 3

var curr_hull_part = null
var curr_attachment_part: Node2D = null
var part_position_offset: Vector2 = Vector2.ZERO
var part_position_origin: Vector2 = Vector2.ZERO
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
		curr_attachment_part.position = mouse_position + part_position_offset
	pass


func _input(event: InputEvent) -> void:
	#print(event)
	
	# CLEAR SELECTED PART
	# remember to clear part from part_menue too
	if event.is_action_pressed("clear_selected_part"):
		parts_menu.clear_grabbed_part()
		if curr_attachment_part:
			curr_attachment_part.queue_free()
			curr_attachment_part = null
	
	if curr_attachment_part:
		# ROTATE SELECTED PART
		if event.is_action_pressed("rotate_part"):
				rotate_part()
		
		# CHANGE SELEECTED PART ANCHOR POINT
		if event.is_action_pressed("change_anchor_point"):
				change_anchor_point()

		# TRACK MOUSE FOR PART MOVE
		if event is InputEventMouseMotion:
			mouse_position = event.position
			pass
		
		if event is InputEventMouseButton \
				and (event.button_index == MOUSE_BUTTON_LEFT) \
				and event.is_pressed():
			place_part()
			pass
			


func update_mouse_part_display(part_data: PartData) -> void:
	
	if part_data.is_hull():
		update_hull(part_data)
	else:
		# HANDLE A SHIP PART
		update_current_grabbed_part(part_data)
		pass
	
	pass


func update_hull(part_data: PartData):
	
	if curr_hull_part:
		if curr_hull_part.name == part_data.name:
			return
		else:
			print('Get user confirmation that this will delete current ship build!')
			pass
		hull_anchor_point.get_child(0).queue_free()
	
	var hull_part = part_data.part_scene.instantiate()
	hull_anchor_point.add_child(hull_part)
	hull_part.set_scale(hull_part.get_scale() * part_up_scale)
	curr_hull_part = part_data


func update_current_grabbed_part(part_data: PartData):
	# ensure that current part attached to hand is removed
	if curr_attachment_part:
		curr_attachment_part.queue_free()
	
	# create new part instanse for scenes
	var attachment_part = part_data.part_scene.instantiate()
	add_child(attachment_part)
	attachment_part.set_scale(attachment_part.get_scale() * part_up_scale)
	attachment_part.position = mouse_drag_limit.position
	
	# hide attachement points
	var attachment_base = attachment_part.find_child("Attachment_Base")
	if attachment_base:
		attachment_base.hide()
	curr_attachment_part = attachment_part
	
	# setup current anchor point
	var anchor_base = attachment_part.find_child("Anchor_Base")
	if anchor_base:
		var anchor_point = anchor_base.get_current_anchor_point()
		print("anchor_point: ", anchor_point.position)

		part_position_offset = Vector2(
			anchor_point.position.x,
			anchor_point.position.y
		) * part_up_scale
		part_position_origin = Vector2(
			anchor_point.position.x,
			anchor_point.position.y
		) * part_up_scale
	

func mouse_part_in_drag_range() -> bool:
	
	if mouse_position.x < mouse_drag_limit.position.x \
			or mouse_position.x > mouse_drag_limit.position.x + mouse_drag_limit.size.x:
		return false
	
	if mouse_position.y < mouse_drag_limit.position.y \
			or mouse_position.y > mouse_drag_limit.position.y + mouse_drag_limit.size.y:
		return false
	
	return true


func rotate_part():
	if curr_attachment_part:
		
		var anchor_base = curr_attachment_part.find_child("Anchor_Base")
		var anchor_point = null
		if anchor_base:
			anchor_point = anchor_base.get_current_anchor_point()
		
		# rotate part
		if curr_attachment_part.rotation_degrees == 270:
			curr_attachment_part.rotate(deg_to_rad(-270))
		else:
			curr_attachment_part.rotate(deg_to_rad(90))
		
		# adjust offset
		if anchor_point:
			adjust_offset(curr_attachment_part.rotation_degrees, anchor_point)


func change_anchor_point():
	if curr_attachment_part:
		var anchor_base = curr_attachment_part.find_child("Anchor_Base")
		if anchor_base:
			var anchor_point = anchor_base.set_next_anchor_point()
			part_position_offset = Vector2(
				anchor_point.position.x,
				anchor_point.position.y
			) * part_up_scale
			part_position_origin = Vector2(
				anchor_point.position.x,
				anchor_point.position.y
			) * part_up_scale
			adjust_offset(curr_attachment_part.rotation_degrees, anchor_point)


func adjust_offset(degree_rotation, anchor_point):
	match degree_rotation:
		0.0:
			part_position_offset = part_position_origin
		90.0:
			part_position_offset = Vector2(
				-anchor_point.position.y,
				-anchor_point.position.x
			) * part_up_scale
		180.0:
			part_position_offset = Vector2(
				-anchor_point.position.x,
				-anchor_point.position.y
			) * part_up_scale
		270.0: 
			part_position_offset = Vector2(
				anchor_point.position.y,
				anchor_point.position.x
			) * part_up_scale


func place_part():
	# check if part can be placed
	print('Place Part')
	parts_menu.clear_grabbed_part()
	curr_attachment_part = null
	pass
