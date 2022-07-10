tool
extends EditorPlugin


func _enter_tree():
	if Engine.editor_hint:
		add_autoload_singleton("Persistence", "res://addons/nested-saving/Persistence.tscn")


func _exit_tree():
	if Engine.editor_hint:
		remove_autoload_singleton("Persistence")