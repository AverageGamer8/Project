extends Node


var game_scene: PackedScene = preload("res://scenes/levels/level_6.tscn") # need to randomize level order
@onready var start_button: Button = $MarginContainer/VBoxContainer/VBoxContainer/StartButton
# also perhaps store images of levels

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# lets us use arrow keys
	start_button.grab_focus()


func _on_start_button_pressed() -> void:
	Global.player_health = 100
	Global.player_temperature = 50
	Global.player_money = 0
	Global.player_ammo = 5
	Global.levels_cleared = 0
	Global.play_button_press_sound()
	Global.change_level(game_scene)


func _on_quit_button_pressed() -> void:
	Global.play_button_press_sound()
	get_tree().quit()
