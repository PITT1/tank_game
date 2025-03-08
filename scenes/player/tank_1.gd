extends VehicleBody3D

@export var ENGINE_POWER = 100
@export var BRAKE_FORCE = 100

var on_brake: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	engine_force = Input.get_axis("up", "Down") * ENGINE_POWER
