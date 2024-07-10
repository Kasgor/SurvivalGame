extends Interactable
class_name  Pickuppable

@export var item_key: ItemConfig.KEYS

@onready var parent: Node3D = get_parent()

func start_interaction():
	EventSystem.INV_try_to_pickup_item.emit(item_key, destroy_yourself)

func destroy_yourself():
	parent.queue_free()
