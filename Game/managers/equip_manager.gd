extends Node

var active_hotbar_slot
var hotbar: Array

func _enter_tree():
	hotbar.resize(8)
	EventSystem.INV_hotbar_updated.connect(hotbar_updated)
	EventSystem.EQU_hotkey_pressed.connect(hotbar_pressed)
	EventSystem.EQU_delete_equipped_item.connect(delete_equipped_item)
	

func _ready():
	EventSystem.EQU_active_hotbar_slot_updated.emit(null)

func hotbar_updated(_hotbat: Array):
	hotbar = _hotbat
	
	if active_hotbar_slot!= null and hotbar[active_hotbar_slot] == null:
		EventSystem.EQU_unequip_item.emit()
		active_hotbar_slot = null
		EventSystem.EQU_active_hotbar_slot_updated.emit(null)


func hotbar_pressed(hotkey: int):
	var idx = hotkey-1
	
	if hotbar[idx]==null:
		return
	if idx!= active_hotbar_slot:
		active_hotbar_slot = idx
		EventSystem.EQU_equip_item.emit(hotbar[idx])
		EventSystem.EQU_active_hotbar_slot_updated.emit(idx)
	else :
		active_hotbar_slot = null
		EventSystem.EQU_unequip_item.emit()

func delete_equipped_item():
	EventSystem.INV_delete_item_by_index.emit(active_hotbar_slot, true)
	EventSystem.EQU_active_hotbar_slot_updated.emit(null)
	active_hotbar_slot = null
