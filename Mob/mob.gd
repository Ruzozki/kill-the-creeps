extends RigidBody2D

signal Death 

@export var health = 100

func _ready():
	$AnimatedSprite2D.play()
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	$AnimatedSprite2D.animation = mob_types.pick_random()



func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()




func _on_body_entered(_body: Node) -> void:
	if _body.is_in_group("Player"):
		Death.emit()
