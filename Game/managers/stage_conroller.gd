extends Node

func _ready():
	change_stage(StageConfig.KEYS.Island)

func change_stage(key: StageConfig.KEYS):
	for child in get_children():
		child.queue_free()
	
	var stage  = StageConfig.get_stage(key)
	add_child(stage)
