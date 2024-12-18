extends Node2D

#const SHIP_BUILD_MENU_00 = preload("res://Menus/Scenes/ship_build_menu_00.tscn")
@export var build_menu: PackedScene

@onready var ship_point: Node2D = $ShipPoint
@onready var ship_anchor: Node2D = $ShipPoint/ShipAnchor

const SHIP_BUILD_MANAGER = preload("res://ShipBuilder/ship_build_manager.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var ship_save = SHIP_BUILD_MANAGER.get_ship_save()
	if ship_save:
		SHIP_BUILD_MANAGER.build_ship(ship_save, ship_anchor)
		ship_anchor.scale = Vector2.ONE * 2
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	ship_point.rotate(-_delta)
	pass

###############################################################################
#  ██████  ██    ██ ████████ ████████  ██████  ███    ██ ███████ 
#  ██   ██ ██    ██    ██       ██    ██    ██ ████   ██ ██      
#  ██████  ██    ██    ██       ██    ██    ██ ██ ██  ██ ███████ 
#  ██   ██ ██    ██    ██       ██    ██    ██ ██  ██ ██      ██ 
#  ██████   ██████     ██       ██     ██████  ██   ████ ███████ 
###############################################################################

func _on_fly_button_pressed() -> void:
	pass # Replace with function body.


func _on_build_button_pressed() -> void:
	if build_menu:
		get_tree().change_scene_to_file(build_menu.resource_path)
		# TODO: HAVE SOME KINDA RESOUCE THAT SAVE THE MENU AS THE 
		#       PREVIOUS SCENE SO WHEN WE EXIT THE SHIP BUILD WE CAN
		#       "GO BACK"
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.


###############################################################################
#  ███████ ██   ██ ██ ██████      ██       ██████   █████  ██████  
#  ██      ██   ██ ██ ██   ██     ██      ██    ██ ██   ██ ██   ██ 
#  ███████ ███████ ██ ██████      ██      ██    ██ ███████ ██   ██ 
#       ██ ██   ██ ██ ██          ██      ██    ██ ██   ██ ██   ██ 
#  ███████ ██   ██ ██ ██          ███████  ██████  ██   ██ ██████  
###############################################################################

func display_ship(ship_parts: Dictionary) -> void:

	#for key in ship_parts:
		#print(key, " : ", ship_parts[key])
	
	pass
