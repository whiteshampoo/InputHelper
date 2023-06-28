# CC0 by Benedikt Wicklein 2023
@tool
class_name InputResource # v1.5
extends Resource

## Resource for input-handling
##
## This resource provides some shortcuts to
## frequently used [Input]-methods
## and signals to catch action-presses/releases.[br]
## [br]
## Because the signals are not hardcoded, you need to use[br]
## [code]input_res.connect("my_action_released", ...)[/code][br]
## instead of[br]
## [code]input_res.my_action_released.connect(...)[/code]

const SUFFIX_PRESSED: String = "_pressed"
const SUFFIX_RELEASED: String = "_released"

@export_category("Axes")
## List of axes to use with e.g. [code]get_vector(num)[/code]
@export var axes: Array[InputAxis] = [InputAxis.new()]

@export_category("Signals")
## List for the generation of user signals in [method init].
@export var signals: Dictionary = {
	"accept": "ui_accept",
	"select": "ui_select",
	"cancel": "ui_cancel",
}:
	set(new_signals):
		signals = new_signals
		init()


## Generates user-signals for all actions in Array [member signals]
## with suffixes defined in [constant SUFFIX_PRESSED] and [constant SUFFIX_RELEASED].
func init() -> void:
	var action: String = ""
	for sig in signals:
		if not sig is String or not signals[sig] is String:
			push_error("'%s': '%s' is invalid. Key and value must be string!" % [sig, str(signals[sig])])
			signals.erase(sig)
			continue
		action = signals[sig]
		if not InputMap.has_action(action):
			push_error("Action '%s' does not exist!" % action)
			signals.erase(sig)
			continue
		for suffix in [SUFFIX_PRESSED, SUFFIX_RELEASED]:
			if has_signal(sig + suffix):
				continue
			add_user_signal(sig + suffix)


## Checks all actions in [member signals]
## and emits signals if they were pressed or released.
func update() -> void:
	var action: String = ""
	for sig in signals:
		action = signals[sig]
		if Input.is_action_just_pressed(action):
			emit_signal(sig + SUFFIX_PRESSED)
		if Input.is_action_just_released(action):
			emit_signal(sig + SUFFIX_RELEASED)


## Returns [code]true[/code] if the action from
## [member signals] is currently pressed
func is_pressed(action: String) -> bool:
	if action in signals:
		return Input.is_action_pressed(signals[action])
	else:
		push_error("'%s' not in signals!" % action)
		return false


## Shortcut for [code]Input.get_vector(left, right, up, down)[/code] for axis [code]axis[/code].
func get_vector(axis: int = 0) -> Vector2:
	return axes[axis].get_vector()


## Shortcut to get a non-normalized input-vector for axis [code]axis[/code].
func get_square_vector(axis: int = 0) -> Vector2:
	return axes[axis].get_square_vector()

## Shortcut for [code]Input.get_axis(left, right)[/code] for axis [code]axis[/code].
func get_x_axis(axis: int = 0) -> float:
	return axes[axis].get_x_axis()


## Shortcut for [code]Input.get_axis(up, down)[/code] for axis [code]axis[/code].
func get_y_axis(axis: int = 0) -> float:
	return axes[axis].get_y_axis()


## Connects pressed-[code]action[/code]. This action must exist in [member signals]
func connect_pressed(action: String, callable: Callable, flags: int = 0) -> Error:
	return connect(action + SUFFIX_PRESSED, callable, flags)


## Connects released-[code]action[/code]. This action must exist in [member signals]
func connect_released(action: String, callable: Callable, flags: int = 0) -> Error:
	return connect(action + SUFFIX_RELEASED, callable, flags)


## Disconnects a pressed-[code]action[/code].
func disconnect_pressed(action: String, callable: Callable) -> void:
	disconnect(action + SUFFIX_PRESSED, callable)

## Disconnects a released-[code]action[/code].
func disconnect_released(action: String, callable: Callable) -> void:
	disconnect(action + SUFFIX_RELEASED, callable)
