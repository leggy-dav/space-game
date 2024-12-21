extends WeaponBase

class_name BallisticCannon


@onready var timer_time_out: Timer = $TimerTimeOut


@export var projectile_scene: PackedScene

@export_category("Weapon Stats")
@export var propultion_power: float = 10
@export var fire_rate: float = 0.5


var auto_firing: bool = false
var weapon_ready: bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_time_out.wait_time = fire_rate
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if auto_firing and weapon_ready:
		auto_fire()
	pass


func auto_fire():
	_fire()


func fire():
	# called only when signal is emited
	# we use _fire() to shoot the projectile because
	# i don't want to run into the issue of re asigning the full_auto
	# and possible other fields each time we fire
	_fire()
	if full_auto:
		auto_firing = true
	

func _fire():
	# called every time gun is fired
	if projectile_scene:
		var proj = projectile_scene.instantiate()
		get_tree().get_root().add_child(proj)
		proj.position = global_position
		proj.rotation = global_rotation
		
		var imp = (global_position - get_parent().global_position) * propultion_power
		proj.apply_impulse(imp, global_position)
	else:
		print('Warrning! no projectile set for ', self)
	pass
	
	timer_time_out.start()
	weapon_ready = false
	

func cease_fire():
	auto_firing = false


func _on_timer_time_out_timeout() -> void:
	weapon_ready = true
	pass # Replace with function body.
