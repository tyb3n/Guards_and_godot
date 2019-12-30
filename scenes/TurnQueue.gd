extends Node2D

class_name TurnQueue

const Promise = preload("promise.gd")

var animations_playing : bool = false

func initialize():
	pass

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

func play_turn(input_key):
	animations_playing = true

	# state.push(getState())

	yield(self.moveEntities(input_key), "completed")
	yield(self.getGuardsAngry(), "completed")

	animations_playing = false


func moveEntities(input_key):
	var promises : Array = []

	for child in get_children():
		child.prepare_turn(input_key)
		promises.append(child.play_turn())

	if len(promises) != 0:
		yield(Promise.await_all(promises), "completed")


func getGuardsAngry():
	yield(get_tree().create_timer(0.1), "timeout")
