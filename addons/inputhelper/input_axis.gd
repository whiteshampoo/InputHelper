# CC0 by Benedikt Wicklein 2023
class_name InputAxis # v1.0
extends Resource

@export_category("Axis")
## Input Map Action for negative x-axis.
@export var left: String = "ui_left"
## Input Map Action for positive x-axis.
@export var right: String = "ui_right"
## Input Map Action for negative y-axis
@export var up: String = "ui_up"
## Input Map Action for positive y-axis.
@export var down: String = "ui_down"


## Shortcut for [code]Input.get_vector(left, right, up, down)[/code].
func get_vector() -> Vector2:
	return Input.get_vector(left, right, up, down)


## Shortcut to get a non-normalized input-vector.
func get_square_vector() -> Vector2:
	return Vector2(
		Input.get_axis(left, right),
		Input.get_axis(up, down))


## Shortcut for [code]Input.get_axis(left, right)[/code].
func get_x_axis() -> float:
	return Input.get_axis(left, right)


## Shortcut for [code]Input.get_axis(up, down)[/code].
func get_y_axis() -> float:
	return Input.get_axis(up, down)
