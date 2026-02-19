extends Area2D
class_name Interactable

signal interracted

func _ready():
	self.input_event.connect(_on_input_event)

func _on_input_event(_viewport, event, _shape_idx):
	if event is not InputEventMouseButton: return
	if Dialogic.current_timeline != null: return
	
	if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		interracted.emit()
