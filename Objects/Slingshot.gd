extends Node2D

var current_projectile = null
onready var projectiles = get_tree().get_nodes_in_group("projectile")

func load_projectile():
	if len(projectiles) > 0:
		current_projectile = projectiles.pop_back()

func launch_projectile(proj, launch_impulse):
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			load_projectile()
