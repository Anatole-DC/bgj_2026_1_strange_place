extends Timer
class_name GLTimer

@export_file var restart_scene: String

var is_started: bool = false

func _ready():
	assert(restart_scene)
	
func start_loop():
	if is_started:
		return
	self.start()
	is_started = true
	print("Starting game loop")

func get_progress() -> float:
	if not is_started: return 0
	return 1 - (self.time_left / self.wait_time)

func _on_timeout():
	get_tree().change_scene_to_file(restart_scene)
	Dialogic.end_timeline()
	is_started = false
	print("Game loop is over")
