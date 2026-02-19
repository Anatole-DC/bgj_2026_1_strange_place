extends Node
class_name CollectableItem

@export var area: Interactable
@export var collectable: Collectable  # assign the .tres resource in the editor
@export_file("*.dtl") var dialogue: String          # .dtl file to trigger on pickup

func _ready() -> void:
	# Skip if already collected today
	if GameState.current_day != collectable.day:
		area.queue_free()
	if Inventory.has_item(collectable.document_id):
		area.queue_free()
		return
	if GameState.is_task_complete(collectable.document_id + "_collected"):
		area.queue_free()
	area.interracted.connect(_on_interacted)

func _on_interacted() -> void:
	Inventory.add_item(collectable)
	GameState.complete_task(collectable.document_id + "_collected")
	if dialogue != "":
		Dialogic.start(dialogue)
	area.queue_free()
