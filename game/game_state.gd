extends Node

enum Day {FIRST, SECOND, LAST, END}
var current_day: Day

@export var ui: Control
# First day
@export_group("Day 1")
@export_file("*.dtl") var d1_indications: String

var d1_completed_email_tasks: bool = false
var has_post_it: bool = false
var has_shredded_post_it: bool = false
var d1_has_shredded_post_it: bool = false
var d1_has_scanned_post_it: bool = false
var d2_has_shredded_post_it: bool = false
var d2_has_scanned_post_it: bool = false
var d3_has_shredded_post_it: bool = false
var d3_has_scanned_post_it: bool = false

var d1_completed_calling_tasks: bool = false
var called_health_office: bool = false
var checked_budget: bool = false
var find_file: bool = false
var has_shredded_file: bool = false
var d1_has_shredded_file: bool = false
var d1_has_scanned_file: bool = false
var d2_has_shredded_file: bool = false
var d2_has_scanned_file: bool = false
var d3_has_shredded_file: bool = false
var d3_has_scanned_file: bool = false

# Second day
@export_group("Day 2")
@export_file("*.dtl") var d2_indications: String
var called_disaster_management: bool = false
var d2_completed_email_tasks: bool = false

@export_subgroup("D2 Calling")
var d2_completed_calling_tasks: bool = false

# Last Day
@export_group("Day 3")
@export_file("*.dtl") var d3_indications: String
var d3_completed_email_tasks: bool = false
var d3_completed_calling_tasks: bool = false
var daily_indications: String

func _ready():
	current_day = Day.FIRST
	daily_indications = d1_indications

func go_next_day(previous_day: Day):
	reset_furniture_state()
	if previous_day == Day.FIRST:
		current_day = Day.SECOND
		daily_indications = d2_indications
		return
	if previous_day == Day.SECOND:
		has_post_it = false
		current_day = Day.LAST
		daily_indications = d3_indications
		return
	current_day = Day.END
	return

func reset_furniture_state():
	find_file = false
	checked_budget = false
	has_shredded_file = false
	has_shredded_post_it = false

func mark_task_complete(checkbox: CheckBox):
	checkbox.disabled = true
	checkbox.button_pressed = true
