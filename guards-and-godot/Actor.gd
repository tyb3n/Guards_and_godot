extends Node2D

class_name Actor

export var animation_move: float = 0 setget set_animation_move

var next_grid_pos: Vector2
var grid_pos: Vector2


func prepare_turn(event):
  next_grid_pos = grid_pos + get_delta_pos_from_dir(event)

func play_turn():
  $AnimationPlayer.play("Move")
  yield($AnimationPlayer, "animation_finished")
  grid_pos = next_grid_pos


# progress goes from 0 to 1
func set_animation_move(progress: float):
	position = grid_pos.linear_interpolate(next_grid_pos, progress) * 100

func get_delta_pos_from_dir(dir):
  if dir == "ui_up":
    return Vector2(0, -1)
  if dir == "ui_right":
    return Vector2(1, 0)
  if dir == "ui_down":
    return Vector2(0, 1)
  if dir == "ui_left":
    return Vector2(-1, 0)
  assert(0)
