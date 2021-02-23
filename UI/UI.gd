extends Control

var inventoryIsOpen = false

func _ready():
	set_inventory()

func _on_BackpackButton_pressed():
	inventoryIsOpen = !inventoryIsOpen
	set_inventory()

func set_inventory():
	$CanvasLayer/Inventory.visible = inventoryIsOpen
