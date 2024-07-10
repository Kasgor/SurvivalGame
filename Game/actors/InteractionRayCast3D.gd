extends RayCast3D

var is_hitting =false

func check_interaction():
	if is_colliding():
		var collider = get_collider()
		if not collider is Interactable:
			return
		if Input.is_action_just_pressed("interact"):
			
			
			collider.start_interaction()
			
		if not is_hitting:
			is_hitting = true
			EventSystem.BUL_create_bulettin.emit(BulletInConfig.KEYS.InteractionPrompt, collider.prompt)
	else: 
		if is_hitting:
			is_hitting= false
			EventSystem.BUL_delete_bulettin.emit(BulletInConfig.KEYS.InteractionPrompt)
