extends Area2D

@export_file("*.tscn") var navigation_scene: String;

func _ready():
	assert(navigation_scene)

func _on_input_event(_viewport, event, _shape_idx):
	if event is not InputEventMouseButton: return
	if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		get_tree().change_scene_to_file(navigation_scene)
