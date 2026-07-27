extends Area2D

var _prev_pos = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	global_position = _prev_pos if GameManager._knife_stuck else get_global_mouse_position()

func _on_table_mouse_entered() -> void:
	GameManager._knife_stuck = true
	_prev_pos = get_global_mouse_position()

func _on_table_mouse_exited() -> void:
	GameManager._knife_stuck = false
	
	var viewport_pos: Vector2 = get_viewport().get_canvas_transform() * _prev_pos
	get_viewport().warp_mouse(viewport_pos)
