extends Node3D

@onready var anim: AnimationPlayer = $AnimationPlayer
var target = null
@onready var turret: StaticBody3D = $turrent

func _ready() -> void:
	anim.play("idle")


func _physics_process(delta: float) -> void:
	if target != null:
		var direction = target.global_position - turret.global_position
		turret.look_at(turret.global_position + -direction, Vector3.UP)
	
	if delta:
		pass
		
func _on_area_3d_body_entered(body: Node3D) -> void:
	anim.pause()
	target = body
	
func _on_area_3d_body_exited(body: Node3D) -> void:
	anim.play("idle")
	target = null
	
	if body:
		pass
