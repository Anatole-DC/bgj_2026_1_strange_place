extends CanvasLayer

@export var progress: ProgressBar
@export var day_indication: Label

@export_file("*.tscn") var restart_scene: String
@export_file("*.tscn") var game_over_scene: String

func reset_progress():
	progress.value = 0
	day_indication.text = GameState.get_current_day().capitalize() + " day progress"

func _ready():
	reset_progress()

func add_progress(progress_amount: int):
	progress.value += progress_amount
	
	if progress.value != progress.max_value:
		return
		
	GameState.go_next_day()
	reset_progress()
	
	if GameState.current_day == GameState.Day.END:
		hide()
		get_tree().change_scene_to_file(game_over_scene)
		return

	get_tree().change_scene_to_file(restart_scene)
	return
