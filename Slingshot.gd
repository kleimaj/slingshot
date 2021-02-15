extends Line2D

onready var projectile = $"../Projectile"
onready var camera = $"../Projectile/Camera2D"

# Boolean is Projectile on Slingshot (initial value true)
var on_slingshot = true

export var ELASTIC_FORCE = 30
export var TORQUE_FORCE = 25

# Vector2 Impulse Direction stores the direction along which we apply force to the character
var impulse_direction = Vector2.ZERO

func _process(delta):
	if on_slingshot:
		var projectile_relative_position = projectile.position - position
		# The point of the line with index 0 is fixed in the starting position of Projectile; to update the line we only need to update point 1, setting it to the relative position of the projectile.
		points[1] = projectile_relative_position
		# Check if band has been released (check for impulse direction)
		if (impulse_direction.length() > 0):
			# if character is still on rubber band, apply force
			if projectile_relative_position.dot(impulse_direction) <= 0:
				# Apply Elastic Force
				projectile.apply_central_impulse(impulse_direction * ELASTIC_FORCE * projectile_relative_position.length() * delta)
				projectile.apply_torque_impulse(TORQUE_FORCE * delta)
				# Apply Torque
			# else, subject it only to the effects of gravity
			else:
				reset_slingshot()
				center_camera()

func reset_slingshot():
	on_slingshot = false
	points[1] = Vector2.ZERO

func center_camera():
	# Center camera onto character
	camera.drag_margin_bottom = 0.2
	camera.drag_margin_top = 0.2
	camera.drag_margin_left = 0.2
	camera.drag_margin_right = 0.2

func _on_Projectile_released():
	# Turns the projectile to rigid from static (activate physics)
	projectile.mode = RigidBody.MODE_RIGID
	impulse_direction = (position - projectile.position).normalized()
