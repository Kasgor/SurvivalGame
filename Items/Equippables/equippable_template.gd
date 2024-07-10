extends Node3D
class_name EquippableItem


@onready var animation_player = $AnimationPlayer

func _ready():
	for chil in $MeshHolder.get_children():
		if chil is VisualInstance3D:
			chil.layers = 2

func try_to_use():
	if animation_player.is_playing():
		return
	else: animation_player.play("use_item")

