extends RigidBody2D

class_name BallisticBullet

@export var damage: float = 10.0

func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.






func _on_hitbox_area_2d_body_entered(_body: Node2D) -> void:
	pass # Replace with function body.


func _on_hitbox_area_2d_area_entered(_area: Area2D) -> void:
	queue_free()
	pass # Replace with function body.
