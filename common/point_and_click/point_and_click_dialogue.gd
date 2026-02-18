extends Area2D
class_name PointAndClickDialogue

@export_file("*.dtl") var dialogue: String

# Called when the node enters the scene tree for the first time.
func _ready():
	assert(dialogue)


func _on_input_event(_viewport, event, _shape_idx):
	if event is not InputEventMouseButton: return
	if Dialogic.current_timeline != null: return
	
	if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		Dialogic.start(dialogue)
		get_viewport().set_input_as_handled()
