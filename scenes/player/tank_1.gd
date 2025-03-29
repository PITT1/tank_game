extends VehicleBody3D

@export var ENGINE_POWER = 100
@export var STEER_POWER = 500
@export var BRAKE_FORCE = 1
@export var projectile_velocity = 1000
@export var projectile: PackedScene

@export_category("CAMERA")
@export var camera_distance: float = 4
@export var camera_height: float = 4

@onready var R_wheels = [$R_wheel_3, $R_wheel_2, $R_wheel_1]
@onready var L_wheels = [$L_wheel_3, $L_wheel_2, $L_wheel_1]
var l_links_velocity = 0.0
var R_links_velocity = 0.0

var target_offset = Vector2.ZERO
var current_offset = Vector2.ZERO

#orugas

@onready var L_links = $L_oruga.get_children()
@onready var R_links = $R_oruga.get_children()

@onready var pCam: PhantomCamera3D = $PhantomCamera3D


func _process(delta: float) -> void:
	update_track_L_movement()
	update_track_R_movement()
	update_pcam()
	
	if delta:
		pass
	
func _physics_process(delta: float) -> void:
	movement()
	on_fire()
	on_brake()
	
	if delta:
		pass
	
	if Input.is_action_just_pressed("Jump"):
		apply_impulse(Vector3.UP * 200)
	

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

func update_track_L_movement():
	var rpm_wheel = (L_wheels[0].get_rpm()) * 0.03
	var target_progress = -rpm_wheel * 0.01
	l_links_velocity = lerp(l_links_velocity, target_progress, 0.1)
	for link in L_links:
		link.progress += l_links_velocity

func update_track_R_movement():
	var rpm_wheel = (R_wheels[0].get_rpm()) * 0.03
	var target_progress = -rpm_wheel * 0.01
	R_links_velocity = lerp(R_links_velocity, target_progress, 0.1)
	for link in R_links:
		link.progress += R_links_velocity

func update_pcam():
	var forward_direction = -global_transform.basis.z.normalized()
	target_offset = Vector2(forward_direction.x * camera_distance, forward_direction.z * camera_distance)
	current_offset = current_offset.lerp(target_offset, 0.05)
	pCam.follow_offset = Vector3(current_offset.x, camera_height, current_offset.y)
