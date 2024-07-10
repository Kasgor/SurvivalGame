extends HBoxContainer

func _enter_tree():
	EventSystem.INV_hotbar_updated.connect(update_hotbar)
	EventSystem.EQU_active_hotbar_slot_updated.connect(active_slot_updated)
	

func update_hotbar(hotbar: Array):
	for slot in get_children():
		slot.set_item_key(hotbar[slot.get_index()])
	

func active_slot_updated(id):
	for slot in get_children():
		slot.set_highlighted(slot.get_index() == id)
