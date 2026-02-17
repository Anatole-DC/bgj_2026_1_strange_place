extends ColorRect

func _ready():
	self.mouse_filter = Control.MOUSE_FILTER_IGNORE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var loop_progress: float = MainGameLoopTimer.get_progress()
	material.set_shader_parameter("fog_intensity", loop_progress)
