extends OfficeFurniture
class_name Shredder

func _on_used() -> void:
	var doc_id := Inventory.current_document_id()
	if doc_id == "":
		Dialogic.start(furniture_dialogue, "no_document")
		return
	if GameState.is_task_complete(doc_id + "_scanned"):
		Dialogic.start(furniture_dialogue, "file_scanned")
		return
	GameState.use_shredder()
	GameState.complete_task(doc_id + "_shredded")
	Inventory.remove_item(Inventory.items[Inventory.current_item])
	Progress.add_progress(1)
