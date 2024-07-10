extends InvetorySlot
class_name HotBarSlot
const ACTIVE_COLOR =Color.WHITE
const UNACTIVE_COLOR = Color(0.8, 0.8,0.8, 0.6)

func _ready():
	$numTextureRect/NumLabel.text = str(get_index()+1)



func _can_drop_data(at_position, data):
	if not data is InvetorySlot:
		return false
	
	return ItemConfig.get_item_recourse(data.item_key).is_equippable

func set_highlighted(enabled:bool):
	modulate = UNACTIVE_COLOR if not enabled else ACTIVE_COLOR
	
