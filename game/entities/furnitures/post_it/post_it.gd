extends Area2D

@export_file("*dtl") var post_id_indications: String

func _ready():
	if not GameState.has_post_it: return
	queue_free()

func _on_input_event(viewport, event, shape_idx):
	if event is not InputEventMouseButton: return
	if Dialogic.current_timeline != null: return
	
	if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GameState.has_post_it = true
		queue_free()
		Dialogic.start(post_id_indications)
