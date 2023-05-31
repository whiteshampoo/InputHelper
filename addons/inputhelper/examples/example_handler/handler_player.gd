# CC0 by Benedikt Wicklein
extends CharacterBody2D


# This is meant to be an autoload!
@onready var ExampleHandler: InputHandlerNode = $"../FakeAutoload"
# For demonstration purposes only!


@export var movement_speed: float = 256.0
@export var rotation_speed: float = PI / 2.0
@export_range(1, 1) var player: int = 1


func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	
	rotation += ExampleHandler.get_x_axis(player) * rotation_speed * delta
	
	velocity.y = ExampleHandler.get_y_axis(player) * movement_speed
	velocity = velocity.rotated(rotation)
	
	move_and_slide()
