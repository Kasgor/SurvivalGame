extends Node

var bulletins = {
	
}
func _enter_tree():
	EventSystem.BUL_create_bulettin.connect(create_bulletin)
	EventSystem.BUL_delete_bulettin.connect(delete_bulletin)
	
func create_bulletin(key: BulletInConfig.KEYS, extra_arg = null):
	if bulletins.has(key):
		return
	var new_bulletin = BulletInConfig.get_bulletin(key)
	new_bulletin.initialize(extra_arg)
	add_child(new_bulletin)
	bulletins[key] = new_bulletin
	

func delete_bulletin(key: BulletInConfig.KEYS):
	if bulletins.has(key):
		bulletins[key].queue_free()
		bulletins.erase(key)
	
