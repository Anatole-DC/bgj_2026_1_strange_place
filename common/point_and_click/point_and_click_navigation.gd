extends Area2D

@export_file("*.tscn") var navigation_scene: String;

func _ready():
	assert(navigation_scene)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("click"):
		get_tree().change_scene_to_file(navigation_scene)
