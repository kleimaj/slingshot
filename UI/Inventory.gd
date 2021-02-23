extends Node2D

var selected_pill = null
var selected_idx = 0
onready var grid = $GridContainer

signal projectile_change(texture_path)

var map = {}

func _ready():
	#	Show the default selected pill (pill 0)
	#	Assign selected_pill (pill 0)
	set_selected()
	# attach gui input listeners
	for slot in grid.get_children():
		slot.connect("gui_input", self, "slot_gui_input", [slot])
		# create map
		map[slot.name] = map.size()
		
func slot_gui_input(event: InputEvent, slot):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			#	hide currently selected pill
			hide_selected()
			#	Get new idx
			selected_idx = map[slot.name]
			# Set new selected, set new pill
			set_selected()
			# Emit projectile change signal
			emit_signal("projectile_change", get_pill_texture_path())

func get_pill():
	return selected_pill

func get_pill_texture_path():
	return selected_pill.texture.load_path

func hide_selected():
	grid.get_child(selected_idx).get_child(0).hide()

func set_selected():
	grid.get_child(selected_idx).get_child(0).show()
	selected_pill = grid.get_child(selected_idx).get_child(1)
