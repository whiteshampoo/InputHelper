# CC0 by Benedikt Wicklein 2023
class_name InputHandlerNode # v1.3 (requires InputResource v1.5)
extends Node

## Autoload Input Handler
##
## This Node should be used as an Autoload
## to easily access input for one or more inputs/players.
## Add at least one [InputResource] to [member inputs]. 


## List of [InputResource]s. Default-input will be item 0.
@export var inputs: Array[InputResource]:
	set(new_inputs):
		inputs = new_inputs
		init()


## Signals will be automatically fired if this is [code]true[/code][br]
## In other words: This disables [method _input] for this Node,
## which calls [method InputResource.update] for each action-input.
@export var auto_update: bool = true:
	set(new_auto_update):
		auto_update = new_auto_update
		set_process_input(false)


func _ready() -> void:
	init()


## This calls [method InputResource.init] for each input.
func init() -> void:
	if inputs.size() == 0:
		push_error("InputHandler: No inputs added!")
		return
	for input in inputs:
		input.init()


func _input(event: InputEvent) -> void:
	if not event.is_action_type():
		return
	for input in inputs:
		input.update()


## Returns [code]true[/code] if the action from
## [code]input[/code] is currently pressed.
func is_pressed(action: String, input: int = 0) -> bool:
	return inputs[input].is_pressed(action)


## Returns a normalized input-vector from [code]input[/code] for axis [code]axis[/code].
func get_vector(input: int = 0, axis: int = 0) -> Vector2:
	return inputs[input].get_vector(axis)


## Returns a non-normalized input-vector from [code]input[/code] for axis [code]axis[/code].
func get_square_vector(input: int = 0, axis: int = 0) -> Vector2:
	return inputs[input].get_square_vector(axis)


## Returns the value of the x-axis from [code]input[/code] for axis [code]axis[/code].
func get_x_axis(input: int = 0, axis: int = 0) -> float:
	return inputs[input].get_x_axis(axis)


## Returns the value of the y-axis from [code]input[/code] for axis [code]axis[/code].
func get_y_axis(input: int = 0, axis: int = 0) -> float:
	return inputs[input].get_y_axis(axis)


## Connects the pressed-signal for the given [code]action[/code] of [code]input[/code].
## The [code]action[/code] must exist in [member InputResource.signals].
func connect_pressed(action: String, callable: Callable, input: int = 0, flags: int = 0) -> Error:
	return inputs[input].connect_pressed(action, callable, flags)


## Connects the released-signal for the given [code]action[/code] of [code]input[/code].
## The [code]action[/code] must exist in [member InputResource.signals].
func connect_released(action: String, callable: Callable, input: int = 0, flags: int = 0) -> Error:
	return inputs[input].connect_released(action, callable, flags)


## Disconnects a released-signal for the given [code]action[/code] of [code]input[/code]. 
func disconnect_pressed(action: String, callable: Callable, input: int = 0) -> void:
	inputs[input].disconnect_pressed(action, callable)


## Disconnects a released-signal for the given [code]action[/code] of [code]input[/code]. 
func disconnect_released(action: String, callable: Callable, input: int = 0) -> void:
	inputs[input].disconnect_released(action, callable)

