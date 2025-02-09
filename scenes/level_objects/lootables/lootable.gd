extends "res://scenes/level_objects/level_object.gd"


@export var looted: bool = false
@export var money : int
@export var water : float
@export var use_time : float


func _ready():
	interactable = true
	$AnimatedSprite2D.play("default")
	indicator_offset = 100
	$Timer.wait_time = use_time
	EventBus.player_lockpicking_interrupt.connect(interrupt)
	super()

func interaction() -> void:
	if interactable:
		$Timer.start()
		print("loot")
		player.start_picking(use_time)
	pass


func _on_timer_timeout() -> void:
	player.add_money(money)
	player.cool_down(water)
	looted = true
	interactable = false
	$AnimatedSprite2D.play("looted")
	indicator.disappear()
	pass # Replace with function body.

func interrupt():
	$Timer.stop()
