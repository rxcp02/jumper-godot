extends Control

onready var music = $backgroundMusic

func _ready():
	music.play()

func _on_Start_pressed():
	var error_code = get_tree().change_scene("res://Scenes/Level.tscn")
	if error_code != 0:
		print("ERROR: ", error_code)
	
func _on_Exit_pressed():
	get_tree().quit()
