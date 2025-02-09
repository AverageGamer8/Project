extends Node2D

var spawnPos: Vector2

func _ready() -> void:
	global_position = spawnPos
	$AnimatedSprite2D.play("default")
	$Life.start()

func _on_life_timeout() -> void:
	queue_free()
	pass # Replace with function body.
