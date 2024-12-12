extends Area2D

class_name Weapon


@export_category("Weapon Info")
@export var rate_of_fire: float = 0.5
@export var projectile: PackedScene

@export_category("General Part Info")
@export var structural_integrety: float = 100.0 # ship health

@onready var timer: Timer = $Timer
@onready var projectile_spawn_point: Node2D = $Projectile_Spawn_Point


var is_firing: bool = false
var weapon_ready: bool = true

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer.wait_time = rate_of_fire
	#pass # Replace with function body.
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if is_firing and weapon_ready:
		fire_weapon()
		
	pass


func fire_weapon():
	if projectile:
		var proj = projectile.instantiate()
		
		get_tree().get_root().add_child(proj)
		var spawn_point = projectile_spawn_point.global_position
		proj.position = spawn_point
		proj.accelerate_projectile( (spawn_point - global_position) * 20, global_position - spawn_point )
	is_firing = true
	start_cooldown()

func cease_fire():
	is_firing = false


func start_cooldown():
	weapon_ready = false
	timer.start()

func _on_timer_timeout() -> void:
	weapon_ready = true
	pass # Replace with function body.
