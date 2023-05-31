# CC0 by Benedikt Wicklein
extends CharacterBody2D


@export var input: InputResource = null
@export var speed: float = 256.0



func _physics_process(delta: float) -> void:
	velocity = input.get_vector() * speed
	move_and_slide()
