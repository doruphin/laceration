extends Area2D

var prev_pos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED #Input.MOUSE_MODE_CONFINED_HIDDEN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position = prev_pos if GameManager.knife_stuck else get_global_mouse_position()

func _on_table_mouse_entered() -> void:
	GameManager.knife_stuck = true
	prev_pos = get_global_mouse_position()
	
	# what did we just stab
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = prev_pos
	query.collide_with_areas = true
	var res = space_state.intersect_point(query)
	
	# branch off what we just stabbed
	for result in res:
		GameManager.stabbed_location.emit(result.collider.name)

func _on_table_mouse_exited() -> void:
	GameManager.knife_stuck = false
	
	var viewport_pos: Vector2 = get_viewport().get_canvas_transform() * prev_pos
	get_viewport().warp_mouse(viewport_pos)
