# CC0 by Benedikt Wicklein 2023
extends Node2D


@export var input: InputResource = null


func _ready() -> void:
	input.init()
	input.connect_pressed("quit", get_tree().quit)


func _input(event: InputEvent) -> void:
	if event.is_action_type():
		input.update()
	
