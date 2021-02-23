extends Control

var inventoryIsOpen = false
var bookIsOpen = false

func _ready():
	set_inventory()
	set_book()

func _on_BackpackButton_pressed():
	inventoryIsOpen = !inventoryIsOpen
	bookIsOpen = false
	set_inventory()

func _on_BookButton_pressed():
	bookIsOpen = !bookIsOpen
	inventoryIsOpen = false
	set_book()

func set_inventory():
	$CanvasLayer/Inventory.visible = inventoryIsOpen

func set_book():
	$CanvasLayer/Book.visible = bookIsOpen


