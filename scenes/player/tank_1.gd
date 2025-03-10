extends VehicleBody3D

@export var ENGINE_POWER = 100
@export var STEER_POWER = 500
@export var BRAKE_FORCE = 1
@export var projectile_velocity = 1000

@export var projectile: PackedScene

@onready var R_wheels = [$R_wheel_3, $R_wheel_2, $R_wheel_1]
@onready var L_wheels = [$L_wheel_3, $L_wheel_2, $L_wheel_1]
@onready var ray_cast_3d: RayCast3D = $RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	movement()
	on_fire()
	on_brake()
	

func movement():
	var steer = Input.get_axis("Left", "Right")
	var move_dir = Input.get_axis("up", "Down")
	
	if steer != 0:
		for wheel in L_wheels:
			wheel.engine_force = STEER_POWER * -steer
		for wheel in R_wheels:
			wheel.engine_force = STEER_POWER * steer
	else:
		for wheel in L_wheels:
			wheel.engine_force = ENGINE_POWER * move_dir
		for wheel in R_wheels:
			wheel.engine_force = ENGINE_POWER * move_dir

func on_fire():
	if Input.is_action_just_pressed("Fire"):
		var instantia_projectile = projectile.instantiate()
		instantia_projectile.position = global_position + transform.basis.z + Vector3(0, 0.5, 0)
		instantia_projectile.set_linear_velocity(transform.basis.z * 20)
		add_sibling(instantia_projectile)

func on_brake():
	if Input.is_action_just_pressed("Brake"):
		for wheel in L_wheels:
			wheel.brake = BRAKE_FORCE
		for wheel in R_wheels:
			wheel.brake = BRAKE_FORCE
