extends Node

signal stabbed_location(location: String, force: float)
signal points_changed(points: int)
signal lost_game

const BASE_POINTS = 10

# global vars
var playing = true
var knife_stuck = false

# gameplay logic
const MAX_FINGERS = 5
var next_finger = 1
var start_stabbed = false
var points = 0
var order_combo = 1

# scoring logic
var round_timer = Timer.new()

func _ready():
	add_child(round_timer)
	round_timer.start(10)
	stabbed_location.connect(_on_stabbed_location)
	points_changed.connect(_on_points_changed)

func _on_stabbed_location(location: String, force: float):
	var just_started = false
	match location:
		"Knife":
			pass
		"Table":
			pass
		"Hand":
			lost_game.emit()
		"StartZone":
			start_stabbed = true
			just_started = true
		_:
			if (start_stabbed and str(next_finger) == location):
				# happy path, we are in order
				next_finger = next_finger + 1 if next_finger != MAX_FINGERS else 1
				start_stabbed = false
				points_changed.emit(points+BASE_POINTS*min(order_combo, 8)*force)
				order_combo += 1
			else:
				# wrong order
				points_changed.emit(points+BASE_POINTS*force)
				order_combo = 1
				next_finger = 1
				if !just_started:
					start_stabbed = false

func _on_points_changed(new_points: int):
	points = new_points
