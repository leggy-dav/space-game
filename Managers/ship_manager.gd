extends Resource

class_name ShipManager

const SHIP_PARTS_ENGINES = preload("res://ShipBuilderMenu/Groups/ship_parts_engines.tres")

func save_ship(node):
	print('Sav Ship')
	#
	#for item in SHIP_PARTS_ENGINES.part_slots:
		#print(item.part_scene)
		#print(item.part_scene.resource_path)
	#serielaize_ship_part(node)
	pass

func serielaize_ship_part(node, tab_over="\t") -> Dictionary:
	
	#print(tab_over, node, "\t", node.position)
	for child in node.get_children():
		#print(tab_over, child)
		var child_json = serielaize_ship_part(child, tab_over + "\t")
	return {
		
	}

func load_ship(name: String): 
	print("Load Ship")
	pass
