extends Node

@export var mob_scene: PackedScene
var score
@export var Bullet_scene: PackedScene

func _ready() -> void:
	pass


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("shot"):
		var new_bullet = Bullet_scene.instantiate()
		new_bullet.position = $player.position
		new_bullet.rotation = $player.rotation
		add_child(new_bullet)
	if Input.is_action_pressed("shot"):
		$player/AnimatedSprite2D.play("up")
	else:
		$player/AnimatedSprite2D.stop()
		


func Game_over() -> void:
	$Score_Timer.stop()
	$Mob_Timer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$Death_sound.play()
	
	
	
func new_game():
	score = 0
	$player.start($Start_Position.position)
	$Start_Timer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()


func _on_mob_timer_timeout() -> void:
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = $Mob_path/mob_spawm_location
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to the random location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	
	
	


func _on_score_timer_timeout() -> void:
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$Mob_Timer.start()
	$Score_Timer.start()


func _on_mob_death() -> void:
	queue_free()
	
