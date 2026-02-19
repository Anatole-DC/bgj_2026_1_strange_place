extends Resource
class_name Collectable

@export var inventory_sprite: Texture2D
@export var document_id: String  # unique key, e.g. "post_it_day1"
@export var day: GameState.Day         # which day this belongs to
