extends Node2D
const MAX_DISTANCE = 150

export var ELASTIC_FORCE = 5
export var MAX_POINTS = 250
export var GRAVITY = 9.8

var current_projectile = null
var isActive = false
var launch_force = Vector2()
onready var projectiles = get_tree().get_nodes_in_group("projectiles")
onready var rest = $RestPosition
onready var line = $Line2D

func _ready():
	load_projectile()

func _process(delta):
	if isActive:
		update_trajectory(delta)

func load_projectile():
	if len(projectiles) > 0:
		current_projectile = projectiles.pop_back()
		current_projectile.global_position = $RestPosition.global_position

func launch_projectile(proj: RigidBody2D, launch_impulse):
	proj.mode = RigidBody2D.MODE_RIGID
	proj.apply_central_impulse(launch_impulse * ELASTIC_FORCE)
	current_projectile = null

func _input(event):
	pass

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
	isActive = true

func _on_touch_released(event):
	if launch_force.length():
		isActive = false
		# hide line
		line.hide()
		launch_projectile(current_projectile, launch_force)
		launch_force = Vector2()
		$Timer.start()

func _on_touch_drag(event):
	launch_force = (rest.global_position - event.position).clamped(MAX_DISTANCE)
	current_projectile.position = rest.global_position - launch_force


func _on_Timer_timeout():
	load_projectile()

func update_trajectory(delta):
	line.clear_points()
	var pos = rest.position - launch_force
	print(pos)
	var velocity = current_projectile.global_transform.x * launch_force.length()
	for i in MAX_POINTS:
		line.add_point(pos)
		velocity.y += delta * GRAVITY
		pos += velocity * delta
#		if pos.y > 0:
#			break








