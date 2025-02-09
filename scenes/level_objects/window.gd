extends LevelObject

func _ready():
	interactable = true
	indicator_offset = 115
	super()

func interaction() -> void:
	print("exiting")
	level.attempt_exit()
	
