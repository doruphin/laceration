extends Area2D

var prev_pos = Vector2()
var stuck_pos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void: 
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED #Input.MOUSE_MODE_CONFINED_HIDDEN

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	prev_pos = get_global_mouse_position()
	global_position = stuck_pos if GameManager.knife_stuck else prev_pos

# table is kind of misleading, right now it dictates anything stabbable
# as a byproduct, anything stabbable needs to be in the table hitbox
# not sure how to change that, we could also just accept it
func _on_table_mouse_entered() -> void:
	GameManager.knife_stuck = true
	stuck_pos = get_global_mouse_position()
	
	# what did we just stab
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = stuck_pos
	query.collide_with_areas = true
	var res = space_state.intersect_point(query)
	for result in res:
		GameManager.stabbed_location.emit(result.collider.name, Vector2(prev_pos - stuck_pos).length())

func _on_table_mouse_exited() -> void:
	GameManager.knife_stuck = false
	
	var viewport_pos: Vector2 = get_viewport().get_canvas_transform() * stuck_pos
	get_viewport().warp_mouse(viewport_pos)
