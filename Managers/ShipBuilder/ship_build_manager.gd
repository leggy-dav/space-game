extends Resource

class_name ShipBuildManager

const SAVE_SHIP_PATH: String = "user://test-ship-save.json"

###############################################################################
#  ███████  █████  ██    ██ ███████ 
#  ██      ██   ██ ██    ██ ██      
#  ███████ ███████ ██    ██ █████   
#       ██ ██   ██  ██  ██  ██      
#  ███████ ██   ██   ████   ███████ 
###############################################################################

func save_ship(part: PartObject, ship_name: String) -> void:
	var ship_dict = {}
	ship_dict["date"] = Time.get_date_string_from_system()
	ship_dict["name"] = ship_name
	ship_dict["parts"] = _get_child_part_dict(part)
	
	if ship_dict != {}:
		var save_file = FileAccess.open(SAVE_SHIP_PATH, FileAccess.WRITE)
		var json_string = JSON.stringify(ship_dict)
		save_file.store_line(json_string)
		save_file.close()


func _get_child_part_dict(base: PartObject) -> Dictionary:
	var base_dict = {
		"part_id": base.part_id,
		"rotation": base.rotation_degrees,
		"scale_x": base.scale.x,
		"scale_y": base.scale.y,
		"anchor_point": base.get_current_anchor().name,
		"position_x": base.position.x,
		"position_y": base.position.y,
		"connection_points": {}
	}
	
	if base.get_connection_base():
		for point in base.get_connection_points():
			for point_child in point.get_children():
				if point_child is PartObject:
					var point_dict = _get_child_part_dict(point_child)
					if point_dict:
						base_dict["connection_points"][point.name] = point_dict
						
	return base_dict



###############################################################################
#  ██       ██████   █████  ██████  
#  ██      ██    ██ ██   ██ ██   ██ 
#  ██      ██    ██ ███████ ██   ██ 
#  ██      ██    ██ ██   ██ ██   ██ 
#  ███████  ██████  ██   ██ ██████  
###############################################################################

func get_ship_save(file_path: String = "") -> Dictionary:
	
	if not file_path:
		file_path = SAVE_SHIP_PATH
	
	if not FileAccess.file_exists(file_path):
		return {}
	
	var save_file = FileAccess.open(file_path, FileAccess.READ)
	var json_string = ""
	while save_file.get_position() < save_file.get_length():
		json_string += save_file.get_line()
		
	var json = JSON.new()
	
	var parse_result = json.parse(json_string)
	if not parse_result == OK:
		print('JSON Parse Error : ', json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return {}
	print('LOADED')
	return json.data



###############################################################################
#  ██████  ██    ██ ██ ██      ██████      ███████ ██   ██ ██ ██████  
#  ██   ██ ██    ██ ██ ██      ██   ██     ██      ██   ██ ██ ██   ██ 
#  ██████  ██    ██ ██ ██      ██   ██     ███████ ███████ ██ ██████  
#  ██   ██ ██    ██ ██ ██      ██   ██          ██ ██   ██ ██ ██      
#  ██████   ██████  ██ ███████ ██████      ███████ ██   ██ ██ ██      
###############################################################################


#######################################
# Build For Play
#######################################

func build_ship(ship_data: Dictionary, anchor_point) -> void:
	if not ship_data:
		return
	if not anchor_point:
		return 
	
	var parts_list = _generate_parts_array()
	
	var ship_parts = ship_data["parts"]
	
	var part_data = _get_part_match(ship_parts["part_id"], parts_list)
	if part_data is PartData:
		var part_obj = part_data.packed_scene.instantiate()
		if part_obj is PartObject:
			_place_display_part(anchor_point, part_obj, ship_parts)
			
			_add_display_child(ship_parts, part_obj, parts_list)


func _place_display_part(anchor_point, part_obj: PartObject, parts_dict: Dictionary) -> void:
	anchor_point.add_child(part_obj)
	part_obj.global_position = anchor_point.global_position
	part_obj.position = Vector2(parts_dict["position_x"], parts_dict["position_y"])
	part_obj.set_rotation_degrees(parts_dict["rotation"])
	part_obj.scale.x = parts_dict["scale_x"]
	part_obj.scale.y = parts_dict["scale_y"]
	
	var connection_base = part_obj.get_connection_base()
	if connection_base:
		for c_p in connection_base.connection_points:
			c_p.strip_point()
			#c_p.hide_texture()
			#c_p.deactivate()
	
	# we don't need anchors in game, remove em to reduce nodes in scene
	part_obj.remove_anchor_base()
	
	pass


func _add_display_child(part_dict: Dictionary, partent_part: PartObject, parts_list: Array) -> void:
	var connection_base = partent_part.get_connection_base()
	if not connection_base:
		return
	
	for connection_point_name in part_dict["connection_points"]:
		var c_p = connection_base.get_connection_point_by_name(connection_point_name)
		if c_p is ConnectionPoint:
			var new_part_dict = part_dict["connection_points"][connection_point_name]
			var new_part_data = _get_part_match(new_part_dict["part_id"], parts_list)
			if new_part_data is PartData:
				var new_part_obj = new_part_data.packed_scene.instantiate()
				if new_part_obj is PartObject:
					_place_display_part(c_p, new_part_obj, new_part_dict)
					_add_display_child(new_part_dict, new_part_obj, parts_list)
	
	# clear up connection base from unused connection points
	# i hope this might improve game performance since we'll have
	# fewer nodes maybe
	for point in connection_base.connection_points:
		if point is ConnectionPoint:
			if not point.has_part_attached():
				point.queue_free()
			else:
				point.deactivate()
				# TODO : maybe remove signal & detection from connection point
	
	#connection_base.get_connection_points()
	pass

#######################################
# SHIP BUILDER
#######################################

func build_construction_ship(ship_data: Dictionary, connection_point: ConnectionPoint) -> void:
	if not ship_data:
		return
	if not connection_point:
		return 
	
	#var parts_list = _generate_parts_array()
	pass


#######################################
# SHIP DATA RESOURCES
#######################################

func _get_part_match(part_id: String, part_list: Array) -> PartData:
	for part in part_list:
		if part is PartData:
			if part.part_id == part_id:
				return part
	return null


func _get_dir_parts_data(dir_path: String) -> Array:
	var parts_list = []
	
	var dir = DirAccess.open(dir_path)
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		
		if FileAccess.file_exists(dir_path + "/" + file_name):
			var data_part = load(dir_path + "/" + file_name)
			if data_part is PartData:
				parts_list.append(data_part)
	
		file_name = dir.get_next()
	return parts_list


func _generate_parts_array() -> Array:
	var parts_list = []
	
	parts_list += _get_dir_parts_data("res://ShipParts/PartsData/Cockpits/")
	parts_list += _get_dir_parts_data("res://ShipParts/PartsData/Engines/")
	parts_list += _get_dir_parts_data("res://ShipParts/PartsData/Hulls/")
	parts_list += _get_dir_parts_data("res://ShipParts/PartsData/Shields/")
	parts_list += _get_dir_parts_data("res://ShipParts/PartsData/Utilities/")
	parts_list += _get_dir_parts_data("res://ShipParts/PartsData/Weapons/")
	
	return parts_list
