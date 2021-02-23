extends RigidBody2D



#func _on_Projectile_body_entered(body):
#	print("collide")
#	print(body)

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemies"):
		queue_free()

func change_projectile_sprite(texture_path):
	$Sprite.texture.load_path= texture_path
