extends AsteroidBase

class_name AsteroidSimple
## Simple Astroid
##
## Simple astroids are just rocks that float through space. 
## Maybe there will be more advanced asteroids that do stuff like
## break and create enemies or something. 

@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var hitbox_cppd: CollisionPolygon2D = $Hitbox_Area2D/Hitbox_CPPD

@onready var sprite_2d: Sprite2D = $Sprite2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if scale_override != 1.0:
		sprite_2d.scale = sprite_2d.scale * scale_override
		collision_polygon_2d.scale = collision_polygon_2d.scale * scale_override
		hitbox_cppd.scale = hitbox_cppd.scale * scale_override
		pass
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#rotate(rotate_speed)
	pass




func _on_hitbox_area_2d_area_entered(area: Area2D) -> void:
	var area_parent = area.get_parent()
	if area_parent is BallisticBullet:
		damage_asteroid(area_parent.damage)
		
	pass # Replace with function body.


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
	pass # Replace with function body.


func apply_scaling(new_scale) -> void:
	sprite_2d.scale = Vector2.ONE * new_scale
	collision_polygon_2d.scale = Vector2.ONE * new_scale
	hitbox_cppd.scale = Vector2.ONE * new_scale
