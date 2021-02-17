extends RigidBody2D

export var DESTRUCTION_THRESHOLD = 250


func _on_Enemy_body_entered(body):
	if body is RigidBody2D:
		_on_rigid_body_collision(body)

func _on_rigid_body_collision(collider):
	# calculate momentum (M = v * mass)
	var collider_momentum = collider.linear_velocity * collider.mass
	var enemy_momentum = linear_velocity * mass
	var collision_intensity = (collider_momentum - enemy_momentum).length()
	if collision_intensity > DESTRUCTION_THRESHOLD:
		queue_free()
		collider.queue_free()
	

#func _integrate_forces(state):
#	pass
