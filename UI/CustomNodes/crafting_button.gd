extends TextureRect


@onready var icon_texture_rect = $MarginContainer/IconTextureRect
@onready var button = $Button



var item_key

func set_item_key(_item_key):
	item_key = _item_key
	update_icon()

func update_icon():
	icon_texture_rect.texture = ItemConfig.get_item_recourse(item_key).icon

