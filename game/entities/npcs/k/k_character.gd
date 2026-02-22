@tool
extends DialogicPortrait

@export var cover_rect: Rect2

func _get_covered_rect() -> Rect2:
	return cover_rect

func _update_portrait(passed_character:DialogicCharacter, passed_portrait:String) -> void:
	apply_character_and_portrait(passed_character, passed_portrait)
