extends Area2D

class_name ConnectionPoint


@export_category("Connection Exclusion")
@export var exclude_cockpit: bool = false
@export var exclude_engine: bool = false
@export var exclude_shield: bool = false
@export var exclude_utility: bool = false
@export var exclude_weapon: bool = false


@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


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


func _on_mouse_entered() -> void:
	print("Mouse Entered : ", self.name)
	connection_point_mouse_entered.emit(self)
	pass # Replace with function body.


func _on_mouse_exited() -> void:
	print("Mouse Exited : ", self.name)
	connection_point_mouse_exited.emit()
	pass # Replace with function body.
