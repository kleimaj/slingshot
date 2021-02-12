extends Line2D

onready var projectile = $"../Projectile"
onready var camera = $"../Projectile/Camera2D"

# Boolean is Projectile on Slingshot (initial value true)
var on_slingshot = true

func _process(delta):
	if on_slingshot:
		var projectile_relative_position = projectile.position - position
		# The point of the line with index 0 is fixed in the starting position of Projectile; to update the line we only need to update point 1, setting it to the relative position of the projectile.
		points[1] = projectile_relative_position


func _on_Projectile_released():
	pass # Replace with function body.
