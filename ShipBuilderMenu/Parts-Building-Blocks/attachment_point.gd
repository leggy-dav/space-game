extends Node2D


@onready var texture_rect: TextureRect = $TextureRect


@export_category("Attachment Exclude")
#@export_group("Attachment Exclude")
@export var allow_engine: bool = true
@export var allow_sheild: bool = true
@export var allow_util: bool = true
@export var allow_weapon: bool = true

@export_category("Attachment Info")
@export var has_attachment: bool = false

var active: bool = true
var index: int = -1
var texture_hidden: bool = false

signal attach_point_mouse_entered(Area2D)
signal attach_point_mouse_exit()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# TODO : add attachement nodes to array
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_anchor_view"):
		texture_hidden = not texture_hidden
		if texture_hidden:
			texture_rect.hide()
		else:
			texture_rect.show()
		pass

func is_active():
	return active


func activate():
	active = false


func deactivate():
	active = true


func _on_mouse_entered() -> void:
	if active:
		print("Mouse Entered Attachment Point: ", self.name)
		attach_point_mouse_entered.emit(self)
		pass # Replace with function body.


func _on_mouse_exited() -> void:
	if active:
		print("Mouse Exit Attachment Point: ", self.name)
		attach_point_mouse_exit.emit()
	pass # Replace with function body.
