
# InputHelper

This Resource and Node can help you manage your input-actions a little bit easier.

## License

[CC0](https://creativecommons.org/choose/zero/)

Do whatever you want. Attribution not required but appreciated.


## Features

- Input-actions for different scenarios/players as `Resource`
- Shortcuts for some commonly used `Input`-methods
- Use input-actions as `Signal`s
- Fully documented in code


## Reference

### InputResource

#### Properties
| Property | Type | Description |
| :- | :-: | :- |
| `left` | `String` | Action for negative x-axis. |
| `right` | `String` | Action for positive x-axis. |
| `up` | `String` | Action for negative y-axis |
| `down` | `String` | Action for positive y-axis. |
| `signals` | `Dictionary` | List for the generation of user signals in `init`. |

#### Methods
| Method | Return | Description |
| :- | :-: | :- |
| `init()` | `void` | Create signals for all attached actions. |
| `update()` | `void` | Checks inputs and fires signals. |
| `is_pressed(action: String)` | `bool` | Check if action is currently pressed. |
| `get_vector()` | `Vector2` | Gets normalized input for x- and y-axis. |
| `get_square_vector()` | `Vector2` | Gets input for x- and y-axis. |
| `get_x_axis()` | `float` | Gets input for `left`/`right`. |
| `get_y_axis()` | `float` | Gets input for `up`/`down`. |
| `connect_pressed(action: String, callable: Callable, flags: int = 0)` | `Error` | Connects a signal to pressed-action defined in `signals`. |
| `connect_released(action: String, callable: Callable, flags: int = 0)` | `Error` | Connects a signal to released-action defined in `signals`. |
| `disconnect_pressed(action: String, callable: Callable)` | `Error` | Disconnects a signal to pressed-action defined in `signals`. |
| `disconnect_released(action: String, callable: Callable)` | `Error` | Disconnects a signal to released-action defined in `signals`. |

### InputHandlerNode

#### Properties
| Property | Type | Description |
| :- | :-: | :- |
| `inputs` | `Array[InputResource]`| List of InputResources. Order matters! |
| `auto_update` | `bool`| Enables/Disables automatic signal sending |

#### Methods
The parameter `input` in the following methods is the index of the `inputs`-array
| Method | Return | Description |
| :- | :-: | :- |
| `init()` | `void` | Create signals for all attached actions. (Auto-called in `_ready`) |
| `update()` | `void` | Checks inputs and fires signals. (Auto-called if `auto_update` is `true`)|
| `is_pressed(action: String, input: int = 0)` | `bool` | Check if action is currently pressed. |
| `get_vector(input: int = 0)` | `Vector2` | Gets normalized input for x- and y-axis. |
| `get_square_vector(input: int = 0)` | `Vector2` | Gets input for x- and y-axis. |
| `get_x_axis(input: int = 0)` | `float` | Gets input for `left`/`right`. |
| `get_y_axis(input: int = 0)` | `float` | Gets input for `up`/`down`. |
| `connect_pressed(action: String, callable: Callable, input: int = 0, flags: int = 0)` | `Error` | Connects a signal to pressed-action defined in `signals`. |
| `connect_released(action: String, callable: Callable, input: int = 0, flags: int = 0)` | `Error` | Connects a signal to released-action defined in `signals`. |
| `disconnect_pressed(action: String, callable: Callable, input: int = 0)` | `Error` | Disconnects a signal to pressed-action defined in `signals`. |
| `disconnect_released(action: String, callable: Callable, input: int = 0)` | `Error` | Disconnects a signal to released-action defined in `signals`. |

## Usage/Examples

### InputResource
```gdscript
@export var input: InputResource = null # edit in inspector

func _ready() -> void:
	input.init()
	input.connect_pressed("quit", get_tree().quit)


func _input(event: InputEvent) -> void:
	if event.is_action_type():
		input.update()
```

### InputHandlerNode
This requires an `Autoload` with name "InputHandler"
```gdscript
func _ready() -> void:
	InputHandler.connect_pressed("quit", get_tree().quit)

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO

	rotation += InputHandler.get_x_axis(player) * rotation_speed * delta
	
	velocity.y = InputHandler.get_y_axis(player) * movement_speed
	velocity = velocity.rotated(rotation)
	
	move_and_slide()
```
## Authors

- [Benedikt Wicklein](https://github.com/whiteshampoo)

