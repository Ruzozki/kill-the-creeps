extends CanvasLayer

#esto notificara al (main) que se presiono el boton
signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()
	$Message_timer.start()

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $Message_timer.timeout

	$Message.text = "Kill the Creeps!"
	$Message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$Start_Button.show()
	
func update_score(score):
	$Score_label.text = str(score)


func _on_start_button_pressed() -> void:
	$Start_Button.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	$Message.hide()
