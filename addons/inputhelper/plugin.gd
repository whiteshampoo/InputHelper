# CC0 by Benedikt Wicklein 2023

@tool
extends EditorPlugin

const RESOURCE_NAME: String = "InputResource"
const RESOURCE_SCRIPT: String = "res://addons/inputhelper/input_resource.gd"

const HANDLER_NAME: String = "InputHandler"
const HANDLER_SCRIPT: String = "res://addons/inputhelper/input_handler.gd"



func _enter_tree() -> void:
	add_custom_type(RESOURCE_NAME, "Resource", load(RESOURCE_SCRIPT), null)
	add_custom_type(HANDLER_NAME, "Node", load(HANDLER_SCRIPT), null)


func _exit_tree() -> void:
	remove_custom_type(RESOURCE_NAME)
	remove_custom_type(HANDLER_NAME)
