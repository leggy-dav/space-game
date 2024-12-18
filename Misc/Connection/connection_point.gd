extends Area2D

class_name ConnectionPoint


@export_category("Connection Exclusion")
@export var exclude_cockpit: bool = false
@export var exclude_engine: bool = false
@export var exclude_shield: bool = false
@export var exclude_utility: bool = false
@export var exclude_weapon: bool = false


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var texture_rect: TextureRect = $TextureRect

var active: bool = true

signal connection_point_mouse_entered(Area2D)
signal connection_point_mouse_exited()



## Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#pass # Replace with function body.


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass

#func _input(event: InputEvent) -> void:
	##if event.is_action_pressed()
	#pass

func set_active_based_on_part(obj) -> void:
	if obj is CockpitPart:
		if exclude_cockpit:
			self.hide()
		else:
			self.show()
		return
	if obj is EnginePart:
		if exclude_engine:
			self.hide()
		else:
			self.show()
		return
	if obj is ShieldPart:
		if exclude_shield:
			self.hide()
		else:
			self.show()
		return
	if obj is UtilityPart:
		if exclude_utility:
			self.hide()
		else:
			self.show()
		return
	if obj is WeaponPart:
		if exclude_weapon:
			self.hide()
		else:
			self.show()



func has_part_attached() -> bool:
	for child in get_children():
		if child is PartObject:
			return true
	return false

func remove_attached_part() -> void:
	for child in get_children():
		if child is PartObject:
			child.queue_free()


func hide_texture() -> void:
	texture_rect.hide()

func show_texture() -> void:
	texture_rect.show()

func deactivate() -> void:
	active = false

func activate() -> void:
	active = true

func strip_point() -> void:
	texture_rect.queue_free()
	collision_shape_2d.PHYSICS_INTERPOLATION_MODE_OFF
	collision_shape_2d.hide()


func _on_mouse_entered() -> void:
	if active:
		print("Mouse Entered : ", self.name)
		connection_point_mouse_entered.emit(self)
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	if active:
		print("Mouse Exited : ", self.name)
		connection_point_mouse_exited.emit()
	pass # Replace with function body.
