extends Node

enum Day {FIRST, SECOND, LAST, END}
var current_day: Day = Day.FIRST

@export var ui: Control

# First day
@export_group("Day 1")
@export_subgroup("D1 Mailing")
@export var d1_mailing: Control
@export var d1_mailing_task: CheckBox
var d1_completed_email_tasks: bool = false:
	set(value):
		d1_completed_email_tasks = value
		if (value):
			mark_task_complete(d1_mailing_task)
			d1_mailing.hide()
			
@export var document_task: CheckBox


@export var brian_post_it_task: CheckBox
var has_post_it: bool = false:
	set(value):
		has_post_it = value
		if (value): mark_task_complete(brian_post_it_task)

@export_subgroup("D1 Calling")
@export var d1_calling: Control
@export var d1_calling_task: CheckBox
var d1_completed_calling_tasks: bool = false:
	set(value):
		d1_completed_calling_tasks = value
		if (value):
			mark_task_complete(d1_calling_task)
			d1_calling.hide()

var called_health_office: bool = false

@export var checked_budget_task: CheckBox
var checked_budget: bool = false:
	set(value):
		checked_budget = value
		if (value): mark_task_complete(checked_budget_task)

@export var find_file_task: CheckBox
var find_file: bool = false:
	set(value):
		find_file = value
		if (value):
			mark_task_complete(find_file_task)
			mark_task_complete(document_task)

# Second day
var called_disaster_management: bool = false
var d2_completed_email_tasks: bool = false

func _ready():
	ui.propagate_call("set_mouse_filter", [Control.MOUSE_FILTER_IGNORE])

func go_next_day(previous_day: Day):
	if previous_day == Day.FIRST:
		current_day = Day.SECOND
		return
	if previous_day == Day.SECOND:
		current_day = Day.LAST
		return
	current_day = Day.END
	return

func mark_task_complete(checkbox: CheckBox):
	checkbox.disabled = true
	checkbox.button_pressed = true
