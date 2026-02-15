extends Node2D

@export var clock_needle: Polygon2D

func _process(_delta):
	var progress: float = 1 - (MainGameLoopTimer.time_left / MainGameLoopTimer.wait_time)
	clock_needle.rotation = TAU * progress
