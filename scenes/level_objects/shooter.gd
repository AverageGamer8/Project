extends Node2D

var aiming = false
@export var aimsight_color = Color(255, 0, 0, 1)
@export var found_color = Color(255, 255, 0, 1)
@export var bullet_color = Color(255, 255, 0, 1)
@export var aim_width = 2
@export var shoot_width = 4
@export var range = 400

# Called when the node enters the scene tree for the first time.
func _ready():
	$Line2D.set_default_color(aimsight_color) 
	$Line2D.set_width(aim_width)
	var end_point = Vector2(range, 0)
	$Line2D.set_point_position(1, end_point)
	$RayCast2D.set_target_position(end_point)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# if not trying to shoot and see player, prepare to shoot
	if not aiming and $RayCast2D.is_colliding():
		var hit = $RayCast2D.get_collider()
		if hit.get_parent().is_in_group("Player") :
			aiming = true
			$Line2D.set_default_color(found_color)
			$Line2D.set_width(shoot_width)
			$"Aim Timer".start()
		

func _on_timer_timeout():
	# turn yellow and wider
	$Line2D.set_default_color(bullet_color)
	$Line2D.set_width(4)
	if $RayCast2D.is_colliding():
		var hit = $RayCast2D.get_collider()
		if hit.get_parent().is_in_group("Player"): # hurt player
			hit.get_parent().hurt(20)
	$"Shot Lifespan".start()

func _on_shot_lifespan_timeout():
	aiming = false
	$Line2D.set_default_color(aimsight_color)
	$Line2D.set_width(aim_width)
