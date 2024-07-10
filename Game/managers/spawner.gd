extends Node3D

@onready var items = $Items

func _enter_tree():
	EventSystem.SPW_spaw_scene.connect(spawn_scene)
	
func spawn_scene(scene: PackedScene, tform: Transform3D):
	var object := scene.instantiate()
	
	object.global_transform = tform
	items.add_child(object)
