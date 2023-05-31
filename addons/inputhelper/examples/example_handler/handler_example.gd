# CC0 by Benedikt Wicklein 2023
extends Node2D


# This is meant to be an autoload!
@onready var ExampleHandler: InputHandlerNode = $FakeAutoload
# For demonstration purposes only!


func _ready() -> void:
	ExampleHandler.connect_pressed("quit", get_tree().quit)
