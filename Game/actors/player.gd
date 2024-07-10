extends CharacterBody3D


@export var normal_speed := 3.0
@export var sprint_speed := 5.0
@export var jump_velocity := 4.0
@export var gravity:= 0.2
@export var mouse_sensitivity := 0.002
@export var is_sprinting := false
@onready var item_holder = %ItemHolder
@export var walking_energy_change_per_meter = -0.05 #-10
@onready var head = $head
@onready var interaction_ray_cast_3d = $head/InteractionRayCast3D


func _enter_tree():
	EventSystem.PLA_freze_player.connect(set_freeze.bind(true))
	EventSystem.PLA_unfreze_player.connect(set_freeze.bind(false))
	
func set_freeze(freeze: bool):
	set_process(!freeze)
	set_physics_process(!freeze)
	set_process_input(!freeze)
	set_process_unhandled_input(!freeze)

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	move()
	check_walking_energy_change(delta)
	
	if Input.is_action_just_pressed("use_item"):
		item_holder.try_to_use_item()
	
func _process(delta):
	interaction_ray_cast_3d.check_interaction()

func check_walking_energy_change(delta):
	if velocity.x or velocity.z:
		EventSystem.PLA_change_energy.emit(
			delta*walking_energy_change_per_meter*Vector2(velocity.x, velocity.z).length()
		)

func move():
	if is_on_floor():
		is_sprinting = Input.is_action_pressed("sprint") 
		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_velocity
	else:
		velocity.y -= gravity
		is_sprinting=false
	var speed:= normal_speed if not is_sprinting else sprint_speed
	
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := transform.basis*Vector3(input_dir.x, 0, input_dir.y)
	velocity.z =direction.z*speed
	velocity.x =direction.x*speed
	#velocity.y =direction.y*normal_speed
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		look_around(event.relative)


func look_around(relative: Vector2):
	rotate_y(-relative.x*mouse_sensitivity)
	head.rotate_x(-relative.y*mouse_sensitivity)
	head.rotation_degrees.x = clampf(head.rotation_degrees.x, -90, 90)

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	elif event.is_action_pressed("open_crafting_menu"):
		EventSystem.BUL_create_bulettin.emit(BulletInConfig.KEYS.CraftingMenu)
	
	elif event.is_action_pressed("Item_hotkey"):
		EventSystem.EQU_hotkey_pressed.emit(int(event.as_text()))
