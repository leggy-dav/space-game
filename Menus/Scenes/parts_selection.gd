extends Control

class_name PartsSelectControl

const PART_SLOT = preload("res://Menus/part_slot.tscn")

@onready var grid_container: GridContainer = $PanelContainer/MarginContainer/ScrollContainer/GridContainer

@export_category("Part List Default")
@export var ship_part_cockpits: ShipPartList
@export var ship_part_hulls: ShipPartList
@export var ship_part_engines: ShipPartList
@export var ship_part_utilites: ShipPartList
@export var ship_part_weapons: ShipPartList
@export var ship_part_sheilds: ShipPartList

var grabbed_part_data: PartData

signal pickup_part(part_data: PartData)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# ship_part_list_interact
	#ship_part_cockpits.ship_part_list_interact.connect()
	#ship_part_hulls
	#ship_part_engines
	#ship_part_utilites
	#ship_part_weapons
	#ship_part_sheilds
	pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func populate_grid_container(ship_parts: ShipPartList) -> void:
	
	# clear out Grid Container
	for child in grid_container.get_children():
		child.queue_free()
	
	if not ship_parts:
		return
	
	for item_data in ship_parts.part_slots:
		if item_data:
			var new_slot = PART_SLOT.instantiate()
			grid_container.add_child(new_slot)
			new_slot.set_part_info(item_data)
			new_slot.slot_clicked.connect(ship_parts.on_slot_clicked)

func on_ship_part_list_interact(_ship_part_list: ShipPartList, index: int, button_index: int):
	# get part from ship part list
	# inform a parent scene that this part has been grabed so what needs to 
	# be done can be done
	
	match [grabbed_part_data, button_index]:
		[_, MOUSE_BUTTON_LEFT]:
			grabbed_part_data = _ship_part_list.get_slot_data(index)
			
			#if grabbed_part_data.is_hull():
				#pass
			

func _on_hulls_button_pressed() -> void:
	populate_grid_container(ship_part_hulls)
	pass # Replace with function body.


func _on_cockpits_button_pressed() -> void:
	populate_grid_container(ship_part_cockpits)
	pass # Replace with function body.


func _on_engines_button_pressed() -> void:
	populate_grid_container(ship_part_engines)
	pass # Replace with function body.


func _on_utilities_button_pressed() -> void:
	populate_grid_container(ship_part_utilites)
	pass # Replace with function body.


func _on_weapons_button_pressed() -> void:
	populate_grid_container(ship_part_weapons)
	pass # Replace with function body.


func _on_shields_button_pressed() -> void:
	populate_grid_container(ship_part_sheilds)
	pass # Replace with function body.
