extends RigidBody3D
@onready var destruction_timer: Timer = $destruction_timer


func _on_body_entered(body: Node) -> void:
	destruction_timer.start()


func _on_destruction_timer_timeout() -> void:
	queue_free()
