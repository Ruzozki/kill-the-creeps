extends Area2D

signal hit 


@export var speed = 400
var screen_size 


func _ready():
	screen_size = get_viewport_rect().size
	

func _process(delta):
	# velocity is 'Player' move speed
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		rotation += 0.07 
	if Input.is_action_pressed("move_left"):
		rotation -= 0.07
	if Input.is_action_pressed("move_up"):
		position += transform.x * -230 * delta
	if Input.is_action_pressed("move_down"):
		position += transform.x * 230 * delta

	if velocity.length() > 0:
		# normalized function can move diagonal direction.
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)


func start(pos):
	position = pos
	rotation = 0 
	show()
	$CollisionShape2D.disabled = false


func _on_body_entered(_body: Node2D) -> void:
		if _body.is_in_group("Enemy"):
			hide() # Player disappears after being hit.
			hit.emit()
		# Must be deferred as we can't change physics properties on a physics callback.
			$CollisionShape2D.set_deferred("disabled", true)
