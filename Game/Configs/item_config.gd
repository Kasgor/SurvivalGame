class_name  ItemConfig

enum KEYS{
	#pickables 
	Stick, 
	Stone,
	Plant,
	Mushroom,
	Fruit,
	Log,
	Coal,
	Flitstone,
	RawMeat,
	CookedMeat,
	
	#craftables
	Axe,
	Pickaxe,
	Campfire,
	Multitool,
	Rope,
	Tinderbox,
	Torch,
	Tent,
	Raft
}

const CRAFTABLE_ITEM_KEYS :Array[KEYS] = [
	KEYS.Axe,
	#KEYS.Pickaxe,
	#KEYS.Campfire,
	#KEYS.Multitool,
	KEYS.Rope,
	#KEYS.Tinderbox,
	#KEYS.Torch,
	#KEYS.Tent,
	#KEYS.Raft
	]

const ITEM_RESOURCES_PATH:={
	KEYS.Stick:"res://resources/item resources/stick_resource.tres",
	KEYS.Stone:"res://resources/item resources/stone_resource.tres",
	KEYS.Plant:"res://resources/item resources/plant_resource.tres",
	KEYS.Axe: "res://resources/item resources/axe_resource.tres",
	KEYS.Rope: "res://resources/item resources/rope_resource.tres",
	KEYS.Log: "res://resources/item resources/log_resource.tres",
	KEYS.Mushroom: "res://resources/item resources/mushroom_resource.tres",
	
}

static func get_item_recourse(key: KEYS)->ItemResource:
	return load(ITEM_RESOURCES_PATH.get(key))
	
	
	
	
	


const BLUEPRINTS_RESOURCE := {
	KEYS.Axe :"res://resources/blueprint_resources/axe_blueprint_resource.tres",
	KEYS.Rope :"res://resources/blueprint_resources/rope_blueprint.tres",
	
}


static func get_blueprint_recourse(key: KEYS)->BlueprintResource:
	return load(BLUEPRINTS_RESOURCE.get(key))
	
const EQUIPPABLE_RESOURCE := {
	KEYS.Axe: "res://Items/Equippables/equippable_axe.tscn",
	KEYS.Mushroom: "res://Items/Equippables/equippable_mushroom.tscn",
	
	
}


static func get_equippable_recourse(key: KEYS):
	return load(EQUIPPABLE_RESOURCE.get(key))
	

const PICKUPPABLE_ITEM_PATH := {
	KEYS.Log: "res://Items/Iteractables/rigid_pickuppable_log.tscn"
	
}


static func get_pickuppable_item(key: KEYS):
	return load(PICKUPPABLE_ITEM_PATH.get(key))

