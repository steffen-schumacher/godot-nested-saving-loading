tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("Persistence", "res://addons/nested-saving/Persistence.tscn")
	pass


func _exit_tree():
	remove_autoload_singleton("Persistence")
	pass
