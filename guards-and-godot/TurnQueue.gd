extends Node2D

class_name TurnQueue

var pos: Vector2

func initialize():
	pass

func play_turn(input_key):

	for child in get_children():
		child.prepare_turn(input_key)
		child.play_turn()

func _input(event):
	if event.is_action_pressed("ui_down"):
		play_turn("ui_down")
	if event.is_action_pressed("ui_up"):
		play_turn("ui_up")
	if event.is_action_pressed("ui_left"):
		play_turn("ui_left")
	if event.is_action_pressed("ui_right"):
		play_turn("ui_right")
