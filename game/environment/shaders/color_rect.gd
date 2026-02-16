extends ColorRect

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var loop_progress: float = MainGameLoopTimer.get_progress()
	material.set_shader_parameter("fog_intensity", loop_progress)
