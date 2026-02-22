extends Node

enum Day { FIRST, SECOND, LAST, END }
var current_day: Day = Day.FIRST

# Task completion is just a set of string keys
var completed_tasks: Dictionary = {}  # task_id -> true

@export var starting_day: Day = Day.FIRST

@export_group("Office sounds")
@export var printer_player: AudioStreamPlayer
@export var shredder_player: AudioStreamPlayer
@export var clock_sound: AudioStreamPlayer

@export_group("Day 1")
@export_file("*.dtl") var d1_indications: String

@export_group("Day 2")
@export_file("*.dtl") var d2_indications: String

@export_group("Day 3")
@export_file("*.dtl") var d3_indications: String

var daily_indications: String

func _ready() -> void:
	current_day = starting_day
	daily_indications = d1_indications

func get_current_day() -> String:
	return Day.keys()[current_day]

func complete_task(task_id: String) -> void:
	completed_tasks[task_id] = true

func is_task_complete(task_id: String) -> bool:
	return completed_tasks.get(task_id, false)

func go_next_day() -> void:
	Inventory.clear()
	#completed_tasks.clear()  # reset per-day tasks; add exceptions here if needed
	match current_day:
		Day.FIRST:
			current_day = Day.SECOND
			daily_indications = d2_indications
		Day.SECOND:
			current_day = Day.LAST
			daily_indications = d3_indications
		Day.LAST:
			current_day = Day.END

func use_printer() -> void:
	printer_player.play()

func use_shredder() -> void:
	shredder_player.play()
