extends Node3D

@export var attributes : HittableObjectAttributes
@onready var item_spawn_points = $ItemSpawnPoints
@export var residu_static_body : StaticBody3D 
var current_healt: float

func _ready():
	current_healt = attributes.max_health
	
	if residu_static_body!= null:
		remove_child(residu_static_body)


func register_hit(weapon_item_resource: WeaponItemResource):
	if not attributes.weapon_filter.is_empty() and not weapon_item_resource.itme_key in attributes.weapon_filter:
		return
	
	current_healt -= weapon_item_resource.damage
	
	if current_healt<= 0:
		die()
		

func die():
	var scene_to_spawn = ItemConfig.get_pickuppable_item(attributes.drop_item_key)
	
	for marker in item_spawn_points.get_children():
		EventSystem.SPW_spaw_scene.emit(scene_to_spawn, marker.global_transform)
		
	if residu_static_body== null:
		queue_free() 
		return
		
	for child in get_children():
		child.queue_free()
	
	add_child(residu_static_body)
