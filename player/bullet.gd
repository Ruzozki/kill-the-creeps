extends RigidBody2D

@export var bullet_speed = 700

func _process(delta: float) -> void:
	
	position -= transform.x *bullet_speed * delta
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
