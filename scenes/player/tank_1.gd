extends VehicleBody3D

@export var ENGINE_POWER = 100
@export var STEER_POWER = 300
@export var BRAKE_FORCE = 100

@onready var R_wheels = [$R_wheel_3, $R_wheel_2, $R_wheel_1]
@onready var L_wheels = [$L_wheel_3, $L_wheel_2, $L_wheel_1]

var on_brake: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
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
