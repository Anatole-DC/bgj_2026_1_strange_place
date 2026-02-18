extends ColorRect

@export var sleep_buildup_time: float = 5.0  # Seconds to fall asleep
@export var auto_sleep: bool = false  # Automatically darken over time
@export var sleep_progress: Curve

func _ready():
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE

func _process(_delta):
	var loop_progress: float = MainGameLoopTimer.get_progress()
	var sleep_intensity: float = sleep_progress.sample(loop_progress)
	material.set_shader_parameter("sleep_intensity", sleep_intensity)
