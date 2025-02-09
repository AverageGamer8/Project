extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	$"%Button".grab_focus()
	
	if Global.player_health <= 0:
		$ClearScreen/CenterContainer/VBoxContainer/Money.hide()
		Global.result = false
	else:
		$ClearScreen/CenterContainer/VBoxContainer/Money.text = ("Money Collected: $" + str(Global.player_money))
		Global.result = true
	
	$ClearScreen/CenterContainer/VBoxContainer/Levels.text = ("Levels cleared: " + str(Global.levels_cleared))
	get_tree().paused = true






func _on_button_pressed():
	print("return")
	var start = load("res://scenes/game/start_screen.tscn") as PackedScene
	get_tree().paused = false
	Global.change_level(start)
