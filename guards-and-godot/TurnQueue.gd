extends Node2D

class_name TurnQueue

var animations_playing : bool = false

func initialize():
	pass

func play_turn(input_key):
	animations_playing = true
	for child in get_children():
		child.prepare_turn(input_key)

	for child in get_children():
		yield(child.play_turn(), "completed")

	animations_playing = false

func _input(event):
  # Wait for animations to finish
	if animations_playing:
		return

	if event.is_action_pressed("ui_down"):
		play_turn("ui_down")
	elif event.is_action_pressed("ui_up"):
		play_turn("ui_up")
	elif event.is_action_pressed("ui_left"):
		play_turn("ui_left")
	elif event.is_action_pressed("ui_right"):
		play_turn("ui_right")
