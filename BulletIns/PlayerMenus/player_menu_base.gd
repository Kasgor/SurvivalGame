extends Bulletin
class_name  PlayerMenuBase
@onready var inventory_grid_container = %InventoryGridContainer
@onready var item_description = %"Item description"
@onready var extra = %Extra


func _enter_tree():
	EventSystem.INV_inventory_updated.connect(update_inventory)

func _ready():
	EventSystem.PLA_freze_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	EventSystem.INV_ask_update_inventory.emit()
	
	for inv_slots in inventory_grid_container.get_children():
		inv_slots.mouse_entered.connect(show_item_info.bind(inv_slots))
		inv_slots.mouse_exited.connect(hide_item_info)
	for hotbar_slot in get_tree().get_nodes_in_group("HotbarSlots"):
		hotbar_slot.mouse_entered.connect(show_item_info.bind(hotbar_slot))
		hotbar_slot.mouse_exited.connect(hide_item_info)
	
func _close() :
	EventSystem.PLA_unfreze_player.emit()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	EventSystem.BUL_delete_bulettin.emit(BulletInConfig.KEYS.CraftingMenu)


func update_inventory(inventory: Array):
	for i in inventory.size():
		inventory_grid_container.get_child(i).set_item_key(inventory[i])

func show_item_info(slot: InvetorySlot):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or slot.item_key==null:
		return
	
	var item_resource := ItemConfig.get_item_recourse(slot.item_key)
	
	item_description.text = item_resource.display_name + "\n"+\
	item_resource.description
	
	
func hide_item_info():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) :
		return
	
	item_description.text = ""
	
