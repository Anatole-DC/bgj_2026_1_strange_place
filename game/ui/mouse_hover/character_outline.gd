extends Node2D

@export var outline_material: ShaderMaterial
@export var mouse_area: Area2D
@export var source_sprite: CanvasGroup

func _ready() -> void:
	outline_material.set_shader_parameter("outline_enabled", false)
	
	# Hook into mouse signals on the parent Area2D
	mouse_area.mouse_entered.connect(func(): _set_outline(true))
	mouse_area.mouse_exited.connect(func(): _set_outline(false))
	source_sprite.material = outline_material.duplicate()

func _set_outline(enabled: bool) -> void:
	source_sprite.material.set_shader_parameter("outline_enabled", enabled)
