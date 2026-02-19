extends Interactable
class_name OfficeFurniture

@export_file("*.dtl") var furniture_dialogue: String

func _ready() -> void:
	self.interracted.connect(_on_used)

func _on_used() -> void:
	pass  # override in subclass
