extends Node2D

var selected_pill = null
var selected_idx = 0
onready var grid = $GridContainer

func _ready():
	#	Show the default selected pill (pill 0)
	grid.get_child(selected_idx).get_child(0).show()

func get_pill():
	return selected_pill
