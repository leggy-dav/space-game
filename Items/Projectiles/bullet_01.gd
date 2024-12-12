extends RigidBody2D

@onready var timer: Timer = $Timer
@onready var bullet_01: RigidBody2D = $"."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func accelerate_projectile(imp: Vector2, pos: Vector2):
	apply_impulse(imp, pos)



func _on_timer_timeout() -> void:
	queue_free()
	pass # Replace with function body.




func _on_area_2d_body_entered(body: Node2D) -> void:
	if not body == bullet_01:
		print("Bullet On Area2D Body Entered : ", body)
		queue_free()
	pass # Replace with function body.
