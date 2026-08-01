extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.lost_game.connect(_on_lost_game)
	GameManager.points_changed.connect(_on_points_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Timer.text = "%.2f" % GameManager.round_timer.time_left

func _on_lost_game() -> void:
	$CenterText.text = "GAME OVER" 
	
func _on_points_changed(points: int) -> void:
	$Score.text = str(points)
