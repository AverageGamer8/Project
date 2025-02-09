extends Node2D
class_name HeatCell

var temperature : float = 20
var smoke_count : int

@onready var map : TileMapLayer = self.get_parent()
@onready var cell_pos : Vector2i = map.local_to_map(position)
var up_adj : HeatCell
var down_adj : HeatCell
var left_adj : HeatCell
var right_adj : HeatCell
@export var conductivity : float
@export var heat_per_smoke : float
@export var heat_loss : float
@export var environment_temp : float
@export var grid_trans : int

var player : Player = null

func _ready() -> void:
	smoke_count = 0
	up_adj = get_heatcell(cell_pos + Vector2i.UP)
	down_adj = get_heatcell(cell_pos + Vector2i.DOWN)
	left_adj = get_heatcell(cell_pos + Vector2i.LEFT)
	right_adj = get_heatcell(cell_pos + Vector2i.RIGHT)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if(body.is_in_group("Smoke")):
		smoke_count += 1
	if body.is_in_group("Player"):
		player = body
	pass # Replace with function body.


func _on_area_2d_body_exited(body: Node2D) -> void:
	if(body.is_in_group("Smoke")):
		smoke_count -= 1
	if body.is_in_group("Player"):
		player = null
	pass # Replace with function body.

func get_heatcell(cell: Vector2i) -> HeatCell:
	for c: HeatCell in get_tree().get_nodes_in_group("HeatCells"):
		if c.cell_pos == cell:
			return c
	return null


func _on_tick_timeout() -> void:
	add_heat(smoke_count * heat_per_smoke)
	$ColorRect.color.a8 = minf(temperature, 255) / grid_trans
	$Label.text = str(floor(temperature))
	if up_adj:
		var amount = (temperature - up_adj.temperature) * conductivity
		up_adj.add_heat(amount)
		temperature -= amount
	if down_adj:
		var amount = (temperature - down_adj.temperature) * conductivity
		down_adj.add_heat(amount)
		temperature -= amount
	if left_adj:
		var amount = (temperature - left_adj.temperature) * conductivity
		left_adj.add_heat(amount)
		temperature -= amount
	if right_adj:
		var amount = (temperature - right_adj.temperature) * conductivity
		right_adj.add_heat(amount)
		temperature -= amount
	
	temperature -= (temperature - environment_temp) * heat_loss
	
	if player:
		player.conduct_heat(temperature)
		
	

func add_heat(heat : float):
	if temperature > 255:
		return
	temperature += heat
