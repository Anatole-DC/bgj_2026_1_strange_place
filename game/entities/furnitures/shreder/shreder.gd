extends Area2D

@export_file("*.dtl") var shreder_dialogue: String


func _on_input_event(viewport, event, shape_idx):
	if event is not InputEventMouseButton: return
	if Dialogic.current_timeline != null: return
	
	if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Dialogic.start(shreder_dialogue)
