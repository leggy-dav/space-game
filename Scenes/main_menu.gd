extends Node2D

# replace with an actual level
# or level selection menu or something
#const TEST_MAIN = preload("res://test_main.tscn") 
#const SHIP_BUILDER_MENU = preload("res://ShipBuilderMenu/ship_builder_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_fly_ship_pressed() -> void:
	get_tree().change_scene_to_file("res://test_main.tscn")
	pass # Replace with function body.


func _on_btn_build_ship_pressed() -> void:
	get_tree().change_scene_to_file("res://ShipBuilderMenu/ship_builder_menu.tscn")
	pass # Replace with function body.


func _on_btn_quit_pressed() -> void:
	get_tree().quit()
	pass # Replace with function body.
