extends Node2D

@export var interval : float

@export var collision_damage : int

var player : Player = null

func _ready() -> void:
	$Timer.wait_time = interval
	$Timer.start()
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null

func _on_timer_timeout() -> void:
	if player:
		player.hurt(collision_damage)
