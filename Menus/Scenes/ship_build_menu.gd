extends Node2D

class_name ShipBuildMenu

## Header Bar Objects
@onready var cost_label: Label = $MenuHeader/MarginContainer/HBoxContainer/CostLabel
@onready var ship_name_line_edit: LineEdit = $MenuHeader/MarginContainer/HBoxContainer/ShipNameLineEdit

## Main Anchor Point
@onready var ship_anchor_point: ConnectionPoint = $BuildArea/ShipAnchorPoint

signal clear_held_part()

###############################################################################
##  ██   ██ ███████  █████  ██████  ███████ ██████      ██████   █████  ██████  
##  ██   ██ ██      ██   ██ ██   ██ ██      ██   ██     ██   ██ ██   ██ ██   ██ 
##  ███████ █████   ███████ ██   ██ █████   ██████      ██████  ███████ ██████  
##  ██   ██ ██      ██   ██ ██   ██ ██      ██   ██     ██   ██ ██   ██ ██   ██ 
##  ██   ██ ███████ ██   ██ ██████  ███████ ██   ██     ██████  ██   ██ ██   ██    
###############################################################################

func _on_exit_button_pressed() -> void:
	# Exit shit build menu
	pass # Replace with function body.


func _on_save_button_pressed() -> void:
	# Save current ship
	pass # Replace with function body.


func _on_ship_name_line_edit_text_changed(new_text: String) -> void:
	#print("Ship Name : ", new_text)
	pass # Replace with function body.
