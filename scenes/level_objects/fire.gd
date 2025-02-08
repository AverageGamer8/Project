extends Node2D

@export_file("*.tscn") var smoke_addr: String
@export var probability : float
@export var interval : float
@export var smokeVelocity : Vector2
var smoke : PackedScene

var fire_temperature = 1000

var player : Player = null

func _ready() -> void:
	$Timer.wait_time = interval
	$Timer.start()
	$AnimatedSprite2D.play()
	
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null

func _on_timer_timeout() -> void:
	var r = randf()
	if(r <= probability):
		smoke = load(smoke_addr) as PackedScene
		var s = smoke.instantiate()
		s.spawnPos = global_position + Vector2(randf_range(-20, 20), randf_range(-20, 20))
		s.iniSpeed = smokeVelocity + Vector2(0, randf_range(-10, 10))
		s.angSpeed = randf_range(-2, 2)
		add_child(s)
	if player:
		player.conduct_heat(fire_temperature)
