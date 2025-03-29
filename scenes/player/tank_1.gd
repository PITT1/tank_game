extends VehicleBody3D

@export var ENGINE_POWER = 100
@export var STEER_POWER = 500
@export var BRAKE_FORCE = 1
@export var projectile_velocity = 1000

@export var projectile: PackedScene

@onready var R_wheels = [$R_wheel_3, $R_wheel_2, $R_wheel_1]
@onready var L_wheels = [$L_wheel_3, $L_wheel_2, $L_wheel_1]
var l_links_velocity = 0.0
var R_links_velocity = 0.0

#orugas

@onready var L_links = $L_oruga.get_children()
@onready var R_links = $R_oruga.get_children()

@onready var pCam: PhantomCamera3D = $PhantomCamera3D


func _process(delta: float) -> void:
	update_track_L_movement()
	update_track_R_movement()
	update_pcam()
	
func _physics_process(delta: float) -> void:
	movement()
	on_fire()
	on_brake()
	
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
	var forward_speed = -linear_velocity.dot(transform.basis.z)
	var target_progress = forward_speed * 0.01
	l_links_velocity = lerp(l_links_velocity, target_progress, 0.1)
	for link in L_links:
		link.progress += l_links_velocity

func update_track_R_movement():
	var forward_speed = -linear_velocity.dot(transform.basis.z)
	var target_progress = forward_speed * 0.01
	R_links_velocity = lerp(R_links_velocity, target_progress, 0.1)
	for link in R_links:
		link.progress += R_links_velocity

func update_pcam():
	var forward_direction = -global_transform.basis.z.normalized()
	pCam.follow_offset.x = forward_direction.x * 8
	pCam.follow_offset.z = forward_direction.z * 8
