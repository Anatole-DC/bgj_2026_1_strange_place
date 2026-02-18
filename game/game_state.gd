extends Node

enum Day {FIRST, SECOND, LAST, END}
var current_day: Day:
	set(day):
		current_day = day
		if current_day == Day.FIRST:
			d1_mailing.show()
			d1_calling.show()
			d2_mailing.hide()
			d2_calling.hide()
			d3_mailing.hide()
			d3_calling.hide()
		if current_day == Day.SECOND:
			d1_mailing.hide()
			d1_calling.hide()
			d2_mailing.show()
			d2_calling.show()
			d3_mailing.hide()
			d3_calling.hide()
		if current_day == Day.LAST:
			d1_mailing.hide()
			d1_calling.hide()
			d2_mailing.hide()
			d2_calling.hide()
			d3_mailing.show()
			d3_calling.show()
		if current_day == Day.END:
			d1_mailing.hide()
			d1_calling.hide()
			d2_mailing.hide()
			d2_calling.hide()
			d3_mailing.hide()
			d3_calling.hide()

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
@export_group("Day 2")
@export_subgroup("D2 Mailing")
@export var d2_mailing: Control
@export var d2_mailing_task: CheckBox
var called_disaster_management: bool = false
var d2_completed_email_tasks: bool = false:
	set(value):
		d2_completed_email_tasks = value
		if value:
			mark_task_complete(d2_mailing_task)
			d2_mailing.hide()

@export_subgroup("D2 Calling")
@export var d2_calling: Control
@export var d2_calling_task: CheckBox
var d2_completed_calling_tasks: bool = false:
	set(value):
		d2_completed_calling_tasks = value
		if value:
			mark_task_complete(d2_calling_task)
			d2_calling.hide()

# Last Day
@export_group("Day 3")
@export_subgroup("D3 Mailing")
@export var d3_mailing: Control
@export var d3_mailing_task: CheckBox
var d3_completed_email_tasks: bool = false:
	set(value):
		d3_completed_email_tasks = value
		if value:
			mark_task_complete(d3_mailing_task)
			d3_mailing.hide()

@export_subgroup("D3 Calling")
@export var d3_calling: Control
@export var d3_calling_task: CheckBox
var d3_completed_calling_tasks: bool = false:
	set(value):
		d3_completed_calling_tasks = value
		if value:
			mark_task_complete(d3_calling_task)
			d3_calling.hide()

func _ready():
	ui.propagate_call("set_mouse_filter", [Control.MOUSE_FILTER_IGNORE])
	current_day = Day.FIRST

func go_next_day(previous_day: Day):
	reset_furniture_state()
	if previous_day == Day.FIRST:
		current_day = Day.SECOND
		return
	if previous_day == Day.SECOND:
		current_day = Day.LAST
		return
	current_day = Day.END
	return

func reset_furniture_state():
	find_file = false
	checked_budget = false

func mark_task_complete(checkbox: CheckBox):
	checkbox.disabled = true
	checkbox.button_pressed = true
