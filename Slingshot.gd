extends Line2D

onready var projectile = $"../Projectile"
onready var camera = $"../Projectile/Camera2D"

# Boolean is Projectile on Slingshot (initial value true)
var on_slingshot = true

func _process(delta):
	if on_slingshot:
		var projectile_relative_position = projectile.position - position
		points[1] = projectile_relative_position
