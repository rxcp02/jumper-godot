extends CanvasLayer

signal game_over
onready var player : KinematicBody2D = get_tree().get_nodes_in_group("player")[0]

func _ready():
	GLOBAL.bombs = 0
	GLOBAL.time = 0
	GLOBAL.score = 0
	get_node("Scores/Lifebar").max_value = player.health

func _process(_delta):
	if is_instance_valid(player):
		get_node("Scores/Lifebar").value = player.health

func _physics_process(_delta):
	$Scores/Score.text = str(GLOBAL.bombs)
	$Scores/Score2.text = str(GLOBAL.time)
	$GameOverContainer/HBoxContainer/FinalScore.text = str(GLOBAL.score)

func game_over():
	emit_signal("game_over")
	$GameOverContainer.visible = true
	$Scores.visible = false
	
func _on_Restart_pressed():
	get_tree().call_deferred("reload_current_scene")
	
func _on_Player_tree_exiting():
	game_over()

func _on_TextureProgress_value_changed(value):
	if value <= 0:
		player.queue_free()
