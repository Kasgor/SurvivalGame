class_name StageConfig

enum KEYS{
	Island
}

const STAGE_PATHS = {
	KEYS.Island :  "res://stages/island.tscn"
}

static func get_stage (key: KEYS) :
	return load(STAGE_PATHS.get(key)).instantiate()
