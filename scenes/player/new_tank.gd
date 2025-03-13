extends VehicleBody3D

@export var ENGINE_POWER = 200
@export var STEER_POWER = 100
@export var BRAKE_FORCE = 1

@onready var R_wheels = [$R_3, $R_2, $R_1]
@onready var L_wheels = [$L_3, $L_2, $L_1]

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	movement()

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
