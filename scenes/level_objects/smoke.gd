extends RigidBody2D

var type : int
var size : float
var spawnPos : Vector2
var iniSpeed : Vector2
var angSpeed : float
@export var max_speed_up : float
@export var growing_rate : float
@export var heat : float
var k : float

@onready var heat_map : TileMapLayer = self.get_parent().get_parent().get_parent().get_child(3)

func _ready() -> void:
	var k = gravity_scale * mass * 980 / max_speed_up
	global_position = spawnPos
	linear_velocity = iniSpeed
	type = randi_range(1, 4)
	size = randf_range(0.25, 0.5)
	$AnimatedSprite2D.apply_scale(size * Vector2(1,1))
	$AnimatedSprite2D.animation = str(type)
	$AnimationPlayer.play("fade")
	$Life.start()


func _physics_process(delta: float) -> void:
	add_constant_force(linear_velocity * k)
	$AnimatedSprite2D.rotation_degrees += angSpeed
	$AnimatedSprite2D.scale += growing_rate * size * Vector2(1,1) * delta


func _on_life_timeout() -> void:
	queue_free()
