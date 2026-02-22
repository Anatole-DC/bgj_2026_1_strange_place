extends CanvasLayer

@export var progress: ProgressBar


func add_progress(progress_amount: int):
	progress.value += progress_amount

func remove_progress(progress_amount: int):
	progress.value -= progress_amount
