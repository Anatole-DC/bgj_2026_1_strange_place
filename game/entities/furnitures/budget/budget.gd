extends Interactable

@export_file("*.dtl") var budget_dialogue: String

func _on_interracted():
	GameState.complete_task("check_budget")
	Dialogic.start(budget_dialogue)
