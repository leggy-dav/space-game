extends Resource

class_name ShipPartList

@export var part_slots: Array[PartData]

signal ship_part_list_interact(ship_part_list: ShipPartList, index: int, button_index: int)


func get_slot_data(index: int) -> PartData:
	var part_data = part_slots[index]
	if part_data:
		return part_data
	return null


func on_slot_clicked(index, button_index):
	ship_part_list_interact.emit(self, index, button_index)
