extends "res://scenes/level_objects/level_object.gd"


@export var looted: bool = false
@export var locked: bool = false
@export var money : int
@export var water : float


func _ready():
	interactable = true
	indicator_offset = 100
	
	super()

func interaction() -> void:
	if interactable:
		print("loot")
		player.add_money(money)
		player.cool_down(water)
		looted = true
		locked = false
		interactable = false
		indicator.disappear()
	pass
