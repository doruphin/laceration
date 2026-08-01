extends Camera2D

const ALLOWED_SCREEN_WIDTH = 60
const ALLOWED_SCREEN_HEIGHT = 35

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if (GameManager.knife_stuck):
		return
	
	var window_size = get_window().size
	var mouse_pos = get_global_mouse_position()
	
	var x_fraction = mouse_pos.x / (window_size.x/2)
	var y_fraction = mouse_pos.y / (window_size.y/2)
	
	global_position = Vector2(x_fraction * ALLOWED_SCREEN_WIDTH, y_fraction * ALLOWED_SCREEN_HEIGHT)
