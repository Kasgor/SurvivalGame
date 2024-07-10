class_name BulletInConfig

enum KEYS{
	InteractionPrompt,
	CraftingMenu
}

const BULLETIN_PATHS = {
	KEYS.InteractionPrompt : "res://BulletIns/interaction_prompt.tscn",
	KEYS.CraftingMenu : "res://BulletIns/PlayerMenus/crafting_menu.tscn"
}

static func get_bulletin (key: KEYS) :
	return load(BULLETIN_PATHS.get(key)).instantiate()
