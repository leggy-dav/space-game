extends Node2D

class_name ShipBuildMenu

@export var base_anchor_scale: float = 10
var curr_scale: float = 4
var scrole_scalable: bool = false
var mouse_position: Vector2 = Vector2.ZERO
var mouse_offset: Vector2 = Vector2.ZERO
var grabbed_part: PartObject = null
var snap_point: ConnectionPoint = null

var parts_selection_menu: PartsSelectControl

# Header Bar Objects
@onready var cost_label: Label = $MenuHeader/MarginContainer/HBoxContainer/CostLabel
@onready var ship_name_line_edit: LineEdit = $MenuHeader/MarginContainer/HBoxContainer/ShipNameLineEdit

# Main Anchor Point
@onready var ship_anchor_point: ConnectionPoint = $BuildArea/ShipAnchorPoint
@onready var build_area: Control = $BuildArea


# signals
signal clear_held_part()


func _ready() -> void:
	setup_parts_selection_menu($PartsSelection00)
	ship_anchor_point.scale = Vector2.ONE * base_anchor_scale
	pass


func _process(delta: float) -> void:
	move_grabbed_part()


##############################################################################
#  ██ ███    ██ ██████  ██    ██ ████████ 
#  ██ ████   ██ ██   ██ ██    ██    ██    
#  ██ ██ ██  ██ ██████  ██    ██    ██    
#  ██ ██  ██ ██ ██      ██    ██    ██    
#  ██ ██   ████ ██       ██████     ██   
##############################################################################

func _input(event: InputEvent) -> void:
	
	if event.is_action_pressed("click_left") and grabbed_part:
		place_part()
		return
	
	if event.is_action_pressed("click_right"):
		print("Right Click")
		return
	
	if scrole_scalable and event.is_action("scroll_wheel_down"):
		if ship_anchor_point.has_part_attached():
			curr_scale -= 0.1
			if curr_scale < 0.5:
				curr_scale = 0.5
			ship_anchor_point.scale = Vector2.ONE * curr_scale
		return
	
	if scrole_scalable and event.is_action("scroll_wheel_up"):
		if ship_anchor_point.has_part_attached():
			curr_scale += 0.1
			if curr_scale > 20:
				curr_scale = 20
			ship_anchor_point.scale = Vector2.ONE * curr_scale
		return
	
	if event.is_action_pressed("flip_part_x") and grabbed_part:
		print('Flip Part X')
		flip_grabbed_x()
		return
	
	if event.is_action_pressed("flip_part_y") and grabbed_part:
		print('Flip Part Y')
		flip_grabbed_y()
		return
	
	if event.is_action_pressed("next_anchor_point") and grabbed_part:
		set_next_anchor_point()
		return
	
	if event.is_action_pressed("rotate_grabbed_part") and grabbed_part:
		pass
	
	if event.is_action_pressed("escape_key"):
		remove_grabbed_part()
	
	if event is InputEventMouseMotion:
		mouse_position = event.position


##############################################################################
#  ██   ██ ███████  █████  ██████  ███████ ██████      ██████   █████  ██████  
#  ██   ██ ██      ██   ██ ██   ██ ██      ██   ██     ██   ██ ██   ██ ██   ██ 
#  ███████ █████   ███████ ██   ██ █████   ██████      ██████  ███████ ██████  
#  ██   ██ ██      ██   ██ ██   ██ ██      ██   ██     ██   ██ ██   ██ ██   ██ 
#  ██   ██ ███████ ██   ██ ██████  ███████ ██   ██     ██████  ██   ██ ██   ██    
##############################################################################

func _on_exit_button_pressed() -> void:
	# Exit shit build menu
	pass # Replace with function body.


func _on_save_button_pressed() -> void:
	# Save current ship
	save_ship()
	pass # Replace with function body.


func _on_ship_name_line_edit_text_changed(new_text: String) -> void:
	#print("Ship Name : ", new_text)
	pass # Replace with function body.

 
func _on_clear_button_pressed() -> void:
	ship_anchor_point.remove_attached_part()
	ship_anchor_point.show_texture()
	ship_anchor_point.scale = Vector2.ONE * base_anchor_scale
	pass # Replace with function body.


##############################################################################
#  ██████   █████  ██████  ████████ ███████     ███    ███ ███    ██    
#  ██   ██ ██   ██ ██   ██    ██    ██          ████  ████ ████   ██    
#  ██████  ███████ ██████     ██    ███████     ██ ████ ██ ██ ██  ██    
#  ██      ██   ██ ██   ██    ██         ██     ██  ██  ██ ██  ██ ██    
#  ██      ██   ██ ██   ██    ██    ███████     ██      ██ ██   ████ ██ 
##############################################################################
 
func setup_parts_selection_menu(selection_menu) -> void:
	parts_selection_menu = selection_menu
	parts_selection_menu.ship_part_selected.connect(on_part_selected)


func on_part_selected(part_data: PartData):
	if not ship_anchor_point.has_part_attached():
		ship_anchor_point.scale = Vector2.ONE * curr_scale
		var new_part = part_data.packed_scene.instantiate()
		ship_anchor_point.add_child(new_part)
		new_part.position = Vector2.ZERO
		ship_anchor_point.hide_texture()
		connect_connection_points(new_part)
		return
	
	elif not grabbed_part:
		set_grabbed_part(part_data)




###############################################################################
# ██████  ██       █████   ██████ ███████ ███    ███ ███████ ███    ██ ████████ 
# ██   ██ ██      ██   ██ ██      ██      ████  ████ ██      ████   ██    ██    
# ██████  ██      ███████ ██      █████   ██ ████ ██ █████   ██ ██  ██    ██    
# ██      ██      ██   ██ ██      ██      ██  ██  ██ ██      ██  ██ ██    ██    
# ██      ███████ ██   ██  ██████ ███████ ██      ██ ███████ ██   ████    ██    
################################################################################


func _on_build_area_mouse_entered() -> void:
	scrole_scalable = true
	pass # Replace with function body.


func _on_build_area_mouse_exited() -> void:
	scrole_scalable = false
	pass # Replace with function body.


func set_grabbed_part(part_data: PartData) -> void:
	grabbed_part = part_data.packed_scene.instantiate()
	grabbed_part.scale = Vector2.ONE * curr_scale
	add_child(grabbed_part)
	grabbed_part.position = mouse_position
	grabbed_part.hide_connection_base()
	var anchor_point = grabbed_part.get_current_anchor()
	if anchor_point:
		print('Anchor Point', anchor_point)
		print('\t', anchor_point.position)
		mouse_offset = Vector2(
			anchor_point.position.x,
			anchor_point.position.y
		) * grabbed_part.scale


func connect_connection_points(part: PartObject) -> void:
	var connection_points = part.get_connection_points()
	if connection_points:
		for point in connection_points:
			print('Connection Point : ', point)
			point.connection_point_mouse_entered.connect(set_snap_point)
			point.connection_point_mouse_exited.connect(clear_snap_point)


func move_grabbed_part() -> void:
	if grabbed_part:
		if snap_point:
			grabbed_part.position = snap_point.global_position - mouse_offset
		else:
			grabbed_part.position = mouse_position - mouse_offset

func remove_grabbed_part() -> void:
	if grabbed_part:
		mouse_offset = Vector2.ZERO
		grabbed_part.queue_free()
		grabbed_part = null


func set_snap_point(point: ConnectionPoint) -> void:
	snap_point = point
	print("Snap Point: ", snap_point)


func clear_snap_point() -> void:
	snap_point = null


func place_part() -> void:
	if grabbed_part:
		if snap_point:
			grabbed_part.show_connection_base()
			connect_connection_points(grabbed_part)
			grabbed_part.reparent(snap_point)
			for child in snap_point.get_children():
				print("Snap Point Child : ", child)
			snap_point.hide_texture()
			snap_point = null
			grabbed_part = null


func flip_grabbed_x() -> void:
	if grabbed_part:
		#grabbed_part
		grabbed_part.scale.x = -grabbed_part.scale.x
		var anchor = grabbed_part.get_current_anchor()
		mouse_offset = Vector2(
			anchor.position.x,
			anchor.position.y
		) * grabbed_part.scale
		pass

func flip_grabbed_y() -> void:
	if grabbed_part:
		#grabbed_part
		grabbed_part.scale.y = -grabbed_part.scale.y
		var anchor = grabbed_part.get_current_anchor()
		mouse_offset = Vector2(
			anchor.position.x,
			anchor.position.y
		) * grabbed_part.scale

func set_next_anchor_point() -> void:
	if not grabbed_part:
		return 
	
	grabbed_part.set_next_anchor()
	var new_anchor = grabbed_part.get_current_anchor()
	mouse_offset = Vector2(
		new_anchor.position.x,
		new_anchor.position.y
	) * grabbed_part.scale
	pass


################################################################################
#  ███████  █████  ██    ██ ███████     ██ ██       ██████   █████  ██████  
#  ██      ██   ██ ██    ██ ██         ██  ██      ██    ██ ██   ██ ██   ██ 
#  ███████ ███████ ██    ██ █████     ██   ██      ██    ██ ███████ ██   ██ 
#       ██ ██   ██  ██  ██  ██       ██    ██      ██    ██ ██   ██ ██   ██ 
#  ███████ ██   ██   ████   ███████ ██     ███████  ██████  ██   ██ ██████  
################################################################################

func save_ship():
	var ship_dict = {}
	if ship_anchor_point.has_part_attached():
		for child in ship_anchor_point.get_children():
			if child is PartObject:
				ship_dict["date"] = Time.get_date_string_from_system()
				ship_dict["name"] = ship_name_line_edit.text
				ship_dict["parts"] = get_child_part_dict(child)
	
	print(ship_dict)

func get_child_part_dict(base: PartObject) -> Dictionary:
	
	var base_dict = {
		"part_id": base.part_id,
		"rotation": base.rotation_degrees,
		"scale_x": base.scale.x,
		"scale_y": base.scale.y,
		"connection_points": {}
	}
	
	if base.get_connection_base():
		for point in base.get_connection_points():
			for point_child in point.get_children():
				if point_child is PartObject:
					var point_dict = get_child_part_dict(point_child)
					if point_dict:
						base_dict["connection_points"][point.name] = point_dict
						
	return base_dict
