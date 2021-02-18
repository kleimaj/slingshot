extends RigidBody2D

export var DESTRUCTION_THRESHOLD = 250

func _ready():
	mode = RigidBody2D.MODE_STATIC
#func _on_Enemy_body_entered(body):
#	if body is RigidBody2D:
#		_on_rigid_body_collision(body)

func _on_rigid_body_collision(collider):
	# calculate momentum (M = v * mass)
	var collider_momentum = collider.linear_velocity * collider.mass
	var enemy_momentum = linear_velocity * mass
	var collision_intensity = (collider_momentum - enemy_momentum).length()
	if collision_intensity > DESTRUCTION_THRESHOLD:
		queue_free()
		collider.queue_free()

func _on_rigid_body_collision_v2(collider, collider_velocity, enemy_velocity):
	# calculate momentum (M = v * mass)
	var collider_momentum = collider_velocity * collider.mass
	var enemy_momentum = enemy_velocity * mass
	var collision_intensity = (collider_momentum - enemy_momentum).length()
	if collision_intensity > DESTRUCTION_THRESHOLD:
		queue_free()
		collider.queue_free()
	

#
func _integrate_forces(state):
	# iterate over each collider
	for collision_index in state.get_contact_count():
		var collider = state.get_contact_collider_object(collision_index)
		print("COLLISION")
		if collider is RigidBody2D:
			var collider_velocity = state.get_contact_collider_velocity_at_position(collision_index)
			_on_rigid_body_collision_v2(collider, collider_velocity, state.linear_velocity)

func _on_Area2D_body_entered(body):
	if body.is_in_group("projectiles"):
		$Sprite.texture = load("res://GFX/kenney_physicsAssets_v2/PNG/Aliens/alienBlue_round.png")
	
