extends Node

enum Day { FIRST, SECOND, LAST, END }
var current_day: Day = Day.FIRST

# Task completion is just a set of string keys
var completed_tasks: Dictionary = {}  # task_id -> true

@export var starting_day: Day = Day.FIRST
@export_file("*.dtl") var daily_indications: String

@export_group("Office sounds")
@export var printer_player: AudioStreamPlayer
@export var shredder_player: AudioStreamPlayer
@export var clock_sound: AudioStreamPlayer


func _ready() -> void:
	current_day = starting_day
	Dialogic.start(GameState.daily_indications, get_current_day())

func get_current_day() -> String:
	return Day.keys()[current_day]

func complete_task(task_id: String) -> void:
	completed_tasks[task_id] = true

func is_task_complete(task_id: String) -> bool:
	return completed_tasks.get(task_id, false)

func go_next_day() -> void:
	match current_day:
		Day.FIRST:
			current_day = Day.SECOND
		Day.SECOND:
			current_day = Day.LAST
		Day.LAST:
			current_day = Day.END
	Dialogic.start(GameState.daily_indications, get_current_day())
	

func use_printer() -> void:
	printer_player.play()

func use_shredder() -> void:
	shredder_player.play()
