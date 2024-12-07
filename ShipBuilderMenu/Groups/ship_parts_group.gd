extends Resource

class_name ShipPartsGroup

@export var part_slots: Array[PartData]

signal ship_parts_group_interact(ship_parts_group: ShipPartsGroup, index: int, button_index: int)


func get_slot_data(index: int) -> PartData:
	var part_data = part_slots[index]
	if part_data:
		return part_data
	return null


func on_slot_clicked(index, button_index):
	print("Ship Part Group : button_index=", button_index, '\t', part_slots[button_index].name)
	ship_parts_group_interact.emit(self, index, button_index)
	pass
