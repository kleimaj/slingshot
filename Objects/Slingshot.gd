extends Node2D
const MAX_DISTANCE = 150

export var ELASTIC_FORCE = 5

var current_projectile = null
var launch_force = Vector2()
onready var projectiles = get_tree().get_nodes_in_group("projectiles")
onready var rest = $RestPosition

func _ready():
	load_projectile()

func load_projectile():
	if len(projectiles) > 0:
		current_projectile = projectiles.pop_back()
		current_projectile.global_position = $RestPosition.global_position

func launch_projectile(proj: RigidBody2D, launch_impulse):
	proj.mode = RigidBody2D.MODE_RIGID
	proj.apply_central_impulse(launch_impulse * ELASTIC_FORCE)
	current_projectile = null

func _unhandled_input(event):
	if current_projectile == null:
		return
	if event is InputEventScreenTouch:
		if event.pressed:
			_on_touch_pressed(event)
		else:
			_on_touch_released(event)
	if event is InputEventScreenDrag:
		_on_touch_drag(event)

func _on_touch_pressed(event):
	print("pressed", event.position)

func _on_touch_released(event):
	launch_projectile(current_projectile, launch_force)

func _on_touch_drag(event):
	launch_force = (rest.global_position - event.position).clamped(MAX_DISTANCE)
	current_projectile.position = rest.global_position - launch_force
