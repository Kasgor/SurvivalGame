extends Camera3D


@onready var equippable_camera_3d = %EquippableCamera3D


func _process(_delta):
	equippable_camera_3d.global_transform= global_transform
