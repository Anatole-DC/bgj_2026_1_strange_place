extends Timer
class_name GLTimer

@export_file("*.tscn") var restart_scene: String
@export_file("*.tscn") var game_over_scene: String

var is_started: bool = false

func _ready():
	assert(restart_scene)
	
func start_loop():
	print(GameState.current_day)
	if is_started:
		return
	self.start()
	is_started = true
	Dialogic.start(GameState.daily_indications)
	GameState.clock_sound.play()
	print("Starting game loop")

func get_progress() -> float:
	if not is_started: return 0
	return 1 - (self.time_left / self.wait_time)

func _on_timeout():
	print("Game loop is over")
	Dialogic.end_timeline()
	is_started = false
	GameState.go_next_day(GameState.current_day)
	GameState.clock_sound.stop()
	
	if GameState.current_day == GameState.Day.END:
		get_tree().change_scene_to_file(game_over_scene)
		print("Game Over")
		return

	get_tree().change_scene_to_file(restart_scene)
	return
	
