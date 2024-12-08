extends Control


const PART_SLOT = preload("res://ShipBuilderMenu/Parts/part_slot.tscn")

var grabbed_parts_data: PartData

# default grid_conainer are the ship hulls
@onready var grid_container: GridContainer = $PartsDisplay/GridContainer

# may want to have a manager of some sort set this up?
@export var ship_part_hulls: ShipPartsGroup
@export var ship_part_engines: ShipPartsGroup
@export var ship_part_utilites: ShipPartsGroup
@export var ship_part_weapons: ShipPartsGroup
@export var ship_part_sheilds: ShipPartsGroup


signal update_grabbed_parts_display(part_data: PartData)


func _ready() -> void:
	#for item in current_parts_group.part_slots:
	#print(item, '\t', item.name)
	populate_grid_container(ship_part_hulls)
	ship_part_hulls.ship_parts_group_interact.connect(on_ship_parts_group_interact)
	ship_part_engines.ship_parts_group_interact.connect(on_ship_parts_group_interact)
	ship_part_utilites.ship_parts_group_interact.connect(on_ship_parts_group_interact)
	ship_part_weapons.ship_parts_group_interact.connect(on_ship_parts_group_interact)
	ship_part_sheilds.ship_parts_group_interact.connect(on_ship_parts_group_interact)
	pass


func populate_grid_container(ship_parts: ShipPartsGroup) -> void:
	
	# clear out Grid Container
	for child in grid_container.get_children():
		child.queue_free()
		pass
	
	# create slots for grid container
	for item_data in ship_parts.part_slots:
		if item_data:
			var new_slot = PART_SLOT.instantiate()
			grid_container.add_child(new_slot)
			new_slot.set_part_info(item_data)
			new_slot.slot_clicked.connect(ship_parts.on_slot_clicked) # signal!
		else:
			print("Nill Item Data")
		pass


func on_ship_parts_group_interact(_ship_parts_group: ShipPartsGroup, 
		index: int, button_index: int):
	
	# TODO: add conditional (match) to handle grabbing a part
	match [grabbed_parts_data, button_index]:
		[null, MOUSE_BUTTON_LEFT]:
			grabbed_parts_data = _ship_parts_group.get_slot_data(index)
			
			update_grabbed_parts_display.emit(grabbed_parts_data)
			
			if grabbed_parts_data.is_hull():
				grabbed_parts_data = null
		
		[grabbed_parts_data, MOUSE_BUTTON_LEFT]:
			grabbed_parts_data = _ship_parts_group.get_slot_data(index)
			
			update_grabbed_parts_display.emit(grabbed_parts_data)
			
			if grabbed_parts_data.is_hull():
				
				grabbed_parts_data = null
			
	
	if grabbed_parts_data:
		print("Grabbed Part: ", grabbed_parts_data.name)
	print()


func clear_grabbed_part():
	grabbed_parts_data = null


func _on_hulls_button_pressed() -> void:
	populate_grid_container(ship_part_hulls)
	pass # Replace with function body.


func _on_engines_button_pressed() -> void:
	populate_grid_container(ship_part_engines)
	pass # Replace with function body.


func _on_utility_button_pressed() -> void:
	populate_grid_container(ship_part_utilites)
	pass # Replace with function body.


func _on_weapons_button_pressed() -> void:
	populate_grid_container(ship_part_weapons)
	pass # Replace with function body.


func _on_sheilds_button_pressed() -> void:
	populate_grid_container(ship_part_sheilds)
	pass # Replace with function body.
