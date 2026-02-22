extends OfficeFurniture
class_name Printer

func _on_used() -> void:
	var doc_id := Inventory.current_document_id()
	if doc_id == "":
		Dialogic.start(furniture_dialogue, "no_file")
		return
	if GameState.is_task_complete(doc_id + "_scanned"):
		Dialogic.start(furniture_dialogue, "file_scanned")
		return
	GameState.use_printer()
	GameState.complete_task(doc_id + "_scanned")
	Progress.add_progress(1)
