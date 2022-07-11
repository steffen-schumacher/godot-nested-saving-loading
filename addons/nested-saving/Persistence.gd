extends Node

# Properties that will be saved in any persistent object
# Example Array that saves the visibility of all persistent Nodes:
# ['visible']
export(Array, String) var default_properties : Array = []

# saves the position of Node2Ds and Spatials based on tranform.origin
export var save_position : bool = true

# saves the rotation of Node2Ds and Spatials based on rotation_degrees
export var save_rotation : bool = true

# Edits already instantiated scene to fit the savestate
# Example: load_scene(get_tree(), "user://savegame.save") 
#
# @scene scene to be edited
# @path path where to file is stored
func load_scene(scene : SceneTree, path: String) -> void:
	_clear_initials(scene)
	yield(get_tree(), "idle_frame")
	
	var file = File.new()
	if not file.file_exists(path):
		return

	# warnings-disable
	file.open(path, File.READ)
	while file.get_position() < file.get_len():
		var node_data : Dictionary = parse_json(file.get_line())
		
		var node = _deserialize(node_data)
		
		var parent : Node = scene.get_root().get_node(node_data["parent"])		
		parent.add_child(node)
		
	file.close()

# Creates a text file which stores the state of the scene.
# Example call that saves the current scene: 
# save_scene(get_tree(), "user://savegame.save") 
#
# To make Nodes in the scene persistent, add them to the group 'Persist'.
# You can add a function called '_save()' to your persistent Node.
# Return a dictionary containing extra values you want to save.
# Example function that saves the visibility of the persistent Spatial or Node2D:   
# func _save():
#	return {
#		"visible": visible
#	}
#
# @scene scene tree to be saved
# @path path where to file is stored
func save_scene(scene : SceneTree, path: String) -> void:
	var world  = scene.get_nodes_in_group("Persist")
	var file : File = File.new()
	# warnings-disable
	file.open(path, File.WRITE)
	for n in world:
		if n.filename.empty():
			print("persistent node '%s' is not an instanced scene, skipped" % n.name)
			continue
		
		if n.get_parent().is_in_group("Persist"):
			continue
		
		if "_exclude_from_saving" in n:
			if n._exclude_from_saving:
				continue
				
		var data : Dictionary
		if n.has_method("_save"):
			data = n.call("_save")
		else:
			data = _serialize(n)
		if data != null:
			file.store_line(to_json(data))
	file.close()

# Convert Dictionary to Node
func _deserialize(node_data : Dictionary) -> Node:
	var node : Node
	var node_filename = node_data["filename"]
	if node_filename != '':
		node = load(node_data["filename"]).instance()
	else:
		node = ClassDB.instance(node_data["class"])
	var components = node_data["components"]
	for component in components:
		for child in node.get_children():
			if child.name == component["name"]:
				node.remove_child(child)
				child.queue_free()
				node.add_child(_deserialize(component))
	
	for key in node_data.keys():
		if key in ["filename", "parent", "position", "rotation", "components", "class", "name"]:
			continue
		node.set(key, node_data[key])
	
	if node.is_class("Spatial"):
			if save_position:
				node.transform.origin = Vector3(node_data["position"]["x"], node_data["position"]["y"], node_data["position"]["z"])
			if save_rotation:
				node.rotation_degrees = Vector3(node_data["rotation"]["x"], node_data["rotation"]["y"], node_data["rotation"]["z"])
		
	if node.is_class("Node2D"):
		if save_position:
			node.transform.origin = Vector2(node_data["position"]["x"], node_data["position"]["y"])
		if save_rotation:
			node.rotation_degrees = Vector2(node_data["rotation"]["x"], node_data["rotation"]["y"])

	return node

# Convert Node to Dictionary
func _serialize(to_save : Node, additional_values : Dictionary = {}) -> Dictionary:
	var components = []
	for n in to_save.get_children():
		if n.is_in_group("Persist"):
			var data : Dictionary
			if n.has_method("_save"):
				data = _serialize(n, n.call("_save"))
			else:
				data = _serialize(n)
			if data != null:
				components.append(data)
	additional_values["class"] = to_save.get_class()
	additional_values["filename"] = to_save.get_filename()
	additional_values["components"] = components
	additional_values["name"] = to_save.name
	additional_values["parent"] = to_save.get_parent().get_path()
	if to_save.is_class("Spatial"):
		if save_position:
			additional_values["position"] = {
				"x" : to_save.transform.origin.x,
				"y" : to_save.transform.origin.y,
				"z" : to_save.transform.origin.z
			}
		if save_rotation:
			additional_values["rotation"] = {
				"x" : to_save.rotation_degrees.x,
				"y" : to_save.rotation_degrees.y,
				"z" : to_save.rotation_degrees.z
			}
	if to_save.is_class("Node2D"):
		if save_position:
			additional_values["position"] = {
				"x" : to_save.transform.origin.x,
				"y" : to_save.transform.origin.y,
			}
		if save_rotation:
			additional_values["rotation"] = {
				"x" : to_save.rotation_degrees.x,
				"y" : to_save.rotation_degrees.y,
			}
			
	for key in default_properties:
		if key in to_save:
			additional_values[key] = to_save.get(key)
	
	return additional_values

# Removes existing objects before loading
func _clear_initials(scene : SceneTree) -> void:
	var save_nodes = scene.get_nodes_in_group("Persist")
	for n in save_nodes:
		if "_exclude_from_saving" in n:
				if n._exclude_from_saving:
					continue
		
		var parent = n.get_parent()
		if parent.is_in_group("Persist"):
			continue
		
		if is_instance_valid(parent):
			parent.remove_child(n)
			n.queue_free()
