extends Node


const INVENTORY_SIZE = 28
const HOTBAR_SIZE=8

var inventory :Array = []
var hot_bar :Array = []

func _enter_tree():
	EventSystem.INV_try_to_pickup_item.connect(try_to_pickup_item)
	EventSystem.INV_ask_update_inventory.connect(send_inventory)
	EventSystem.INV_switch_to_item_indexes.connect(switch_to_item_indexes)
	EventSystem.INV_add_item.connect(add_item)
	EventSystem.INV_delete_crafting_blueprint_costs.connect(delete_crafting_blueprint_costs)
	EventSystem.INV_delete_item_by_index.connect(delete_item_by_index)

func _ready():
	inventory.resize(INVENTORY_SIZE)
	hot_bar.resize(HOTBAR_SIZE)
	
	#DELETE ME LATER
	inventory[0] = ItemConfig.KEYS.Axe
	
func try_to_pickup_item(item_key: ItemConfig.KEYS, destroy_pickuppable: Callable):
	if not get_free_slots():
		return
	add_item(item_key)
	destroy_pickuppable.call()

func send_inventory():
	EventSystem.INV_inventory_updated.emit(inventory)
	
func send_hotbar():
	EventSystem.INV_hotbar_updated.emit(hot_bar)

func switch_to_item_indexes(idx1, is_indx1_in_hotbar, idx2, is_indx2_in_hotbar):
	var item1 = inventory[idx1] if not is_indx1_in_hotbar else hot_bar[idx1]
	var item2 = inventory[idx2] if not is_indx2_in_hotbar else hot_bar[idx2]
	if not is_indx1_in_hotbar:
		inventory[idx1] = item2
	else:
		hot_bar[idx1] = item2
	if not is_indx2_in_hotbar:
		inventory[idx2] = item1
	else:
		hot_bar[idx2] = item1
	send_inventory()
	send_hotbar()


func get_free_slots():
	return inventory.count(null)
	
func add_item(item_key:ItemConfig.KEYS):
	for i in inventory.size():
		if inventory[i] == null:
			inventory[i] = item_key
			print(inventory)
			break
	
	send_inventory()
	
func delete_item(item_key: ItemConfig.KEYS):
	if not inventory.has(item_key):
		return
	inventory[inventory.rfind(item_key)] = null
	send_inventory()
	


func delete_crafting_blueprint_costs(costs: Array[BlueprintCostData]):
	for cost in costs:
		for i in cost.amount:
			delete_item(cost.item)
	
	
	
func delete_item_by_index(index:int, is_in_hot_bar: bool):
	if is_in_hot_bar:
		hot_bar[index] = null
		send_hotbar()
	
	else: 
		inventory[index] = null
		send_hotbar()
