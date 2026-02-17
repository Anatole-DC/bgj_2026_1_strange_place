extends Node

enum Day {FIRST, SECOND, LAST, END}
var current_day: Day = Day.FIRST

# First day
var has_post_it: bool = false
var called_health_office: bool = false
var d1_completed_email_tasks: bool = false

# Second day
var called_disaster_management: bool = false
var d2_completed_email_tasks: bool = false

func go_next_day(previous_day: Day):
	if previous_day == Day.FIRST:
		current_day = Day.SECOND
		return
	if previous_day == Day.SECOND:
		current_day = Day.LAST
		return
	current_day = Day.END
	return
