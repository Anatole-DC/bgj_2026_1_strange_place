extends Area2D

func _ready():
	if not GameState.find_file: return
	queue_free()

func _on_input_event(viewport, event, shape_idx):
	if event is not InputEventMouseButton: return
	if Dialogic.current_timeline != null: return
	
	if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GameState.find_file = true
		queue_free()
