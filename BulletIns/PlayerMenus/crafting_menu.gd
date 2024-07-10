extends PlayerMenuBase


@onready var craftable_container = %CraftableContainer

@export var cragtin_buttons_scene: PackedScene

func _ready():
	for cr in ItemConfig.CRAFTABLE_ITEM_KEYS:
		var crafting_button:= cragtin_buttons_scene.instantiate()
		craftable_container.add_child(crafting_button)
		crafting_button.set_item_key(cr)
		crafting_button.button.mouse_entered.connect(show_craftin_info.bind(crafting_button.item_key))
		crafting_button.button.mouse_exited.connect(hide_craftin_info)
		crafting_button.button.pressed.connect(crafting_button_pressed.bind(crafting_button.item_key))
		
	super()

func crafting_button_pressed(item_key: ItemConfig.KEYS):
	
	EventSystem.INV_delete_crafting_blueprint_costs.emit(ItemConfig.get_blueprint_recourse(item_key).costs)
	EventSystem.INV_add_item.emit(item_key)

func show_craftin_info(item_key: ItemConfig.KEYS):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) or item_key==null:
		return
	
	var item_resource := ItemConfig.get_item_recourse(item_key)
	
	item_description.text = item_resource.display_name + "\n"+\
	item_resource.description
	extra.text = "Requirements: "
	
	var blueprint:= ItemConfig.get_blueprint_recourse(item_key)
	
	if blueprint.needs_multitool:
		extra.text+="\n Multitool"	
	if blueprint.needs_tinderbox:
		extra.text+="\n Tinderbox"
	
	for cost in blueprint.costs:
		extra.text += "\n %s: %d" % [ItemConfig.get_item_recourse(cost.item).display_name, cost.amount] 
	
func hide_craftin_info():
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) :
		return
	
	item_description.text = ""
	extra.text = ""
	

func update_inventory(inventory: Array):
	super(inventory)
	for crafting_button in craftable_container.get_children():
		var cost_data  = ItemConfig.get_blueprint_recourse(crafting_button.item_key).costs
		var disable_button = false 
		
		for cost in cost_data:
			if inventory.count(cost.item)<cost.amount:
				disable_button=true
				break
		
		crafting_button.button.disabled = disable_button
