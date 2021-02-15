extends RigidBody2D

# Boolean dragging the Projectile or not
var drag_enabled = false

# Custom signal to apply force to the character (release the slingshot)
signal released

# drag_enabled changes when left mouse button is clicked
func _input_event(viewport, event, shape_idx):
	if mode == MODE_STATIC:
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT:
				drag_enabled = event.pressed
				if (not drag_enabled):
					emit_signal("released")

# moves projectile with cursor on drag_enabled
func _physics_process(delta):
	if drag_enabled:
		position = get_global_mouse_position()


func _on_Button_pressed():
	get_tree().reload_current_scene()
