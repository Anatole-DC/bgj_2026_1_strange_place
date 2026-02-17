extends Node2D

@export var clock_needle: Polygon2D

func _process(_delta):
	var progress: float = MainGameLoopTimer.get_progress()
	clock_needle.rotation = TAU * progress
