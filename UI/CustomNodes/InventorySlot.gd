extends TextureRect
class_name InvetorySlot

@onready var icon_texture_rect = $MarginContainer/IconTextureRect


var item_key

func set_item_key(_item_key):
	item_key = _item_key
	update_icon()

func update_icon():
	if item_key == null:
		icon_texture_rect.texture = null
		return
	
	
	icon_texture_rect.texture = ItemConfig.get_item_recourse(item_key).icon

func _get_drag_data(at_position):
	if item_key!=null:
		var drag_preview = TextureRect.new()
		drag_preview.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		drag_preview.texture = icon_texture_rect.texture
		drag_preview.custom_minimum_size = Vector2(80, 80)
		drag_preview.modulate = Color(1 , 1, 1 , 0.85)
		set_drag_preview(drag_preview)
		
		return self
	
	
	return null
	
func _can_drop_data(at_position, data):
	if item_key!= null and data is HotBarSlot:
		return ItemConfig.get_item_recourse(item_key).is_equippable
	
	return data is InvetorySlot


func _drop_data(at_position, data):
	EventSystem.INV_switch_to_item_indexes.emit(
		data.get_index(),
		data is HotBarSlot,
		get_index(),
		self is HotBarSlot
	)
	
