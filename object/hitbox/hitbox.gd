extends Area3D


signal register_hit

func take_hit(weapon_resource: WeaponItemResource):
	register_hit.emit(weapon_resource)
