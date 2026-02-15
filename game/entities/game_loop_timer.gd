extends Timer

@export_file var restart_scene: String
@export_file var game_over_scene: String

var is_started: bool = false

func _ready():
	assert(restart_scene)
	

func _on_timeout():
	print("Game loop is over")
	get_tree().change_scene_to_file(restart_scene)
	is_started = false

# Called whenever the player navigates
func _on_tree_entered():
	print("Changing tree")
	var current_scene = get_tree().get_current_scene().get_name()
	print("Entering %s" % current_scene)
	
	if current_scene == game_over_scene:
		print("Game over")
		return

	if current_scene == restart_scene and not is_started:
		print("Choose to restart")
		return

	if is_started:
		return

	self.start()
	print("Starting timer")
	is_started = true
