extends CanvasLayer

@export var inventory_ui: Control

var items: Array[Collectable] = []
var current_item: int = 0

const CARD_OFFSET_X := 8.0
const CARD_OFFSET_Y := -4.0
const CARD_ROTATION := 0.5

func add_item(item: Collectable) -> void:
	items.append(item)
	current_item = items.size() - 1
	update_ui()

func remove_item(item: Collectable) -> void:
	var idx := items.find(item)
	if idx == -1:
		return
	items.remove_at(idx)
	current_item = clamp(current_item, 0, max(items.size() - 1, 0))
	update_ui()

func has_item(document_id: String) -> bool:
	return items.any(func(i): return i.document_id == document_id)

func current_document_id() -> String:
	if items.is_empty(): return ""
	return items[current_item].document_id

func clear() -> void:
	items.clear()
	current_item = 0
	update_ui()

func _input(event: InputEvent) -> void:
	if items.is_empty() or not event is InputEventMouseButton or not event.pressed:
		return
	if event.button_index == MOUSE_BUTTON_WHEEL_UP:
		current_item = (current_item - 1 + items.size()) % items.size()
		update_ui()
	elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		current_item = (current_item + 1) % items.size()
		update_ui()

func update_ui() -> void:
	for child in inventory_ui.get_children():
		child.queue_free()
	if items.is_empty():
		return

	var draw_order: Array[int] = []
	for i in items.size():
		if i != current_item:
			draw_order.append(i)
	draw_order.append(current_item)

	for stack_pos in draw_order.size():
		var item_idx: int = draw_order[stack_pos]
		var depth := stack_pos - (draw_order.size() - 1)
		var sprite := Sprite2D.new()
		sprite.texture = items[item_idx].inventory_sprite
		sprite.position = Vector2(depth * CARD_OFFSET_X, depth * abs(CARD_OFFSET_Y))
		sprite.rotation = depth * CARD_ROTATION
		inventory_ui.add_child(sprite)
