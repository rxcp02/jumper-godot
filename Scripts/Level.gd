extends Control

var ball = load("res://Scenes/Ball.tscn")

onready var music = $backgroundMusic
onready var deathSound = $deathSound

func _ready():
	$BallTimer.start()
	randomize()
	music.play()

func _on_BallTimer_timeout():
	get_node("BallPath/BallSpawn").set_offset(randi())
	GLOBAL.bombs += 1
	var x = ball.instance()
	var number = rand_range(200,350)
	x.init(Vector2(number,number))
	add_child(x)
	x.position = get_node("BallPath/BallSpawn").position
	$BallTimer.wait_time = 8
	$BallTimer.start()

func _on_SurvivedTimer_timeout():
	GLOBAL.time += 1
	GLOBAL.score = GLOBAL.time * GLOBAL.bombs
	$SurvivedTimer.wait_time = 1
	$SurvivedTimer.start()

func _on_Player_tree_exiting():
	$BallTimer.stop()
	$SurvivedTimer.stop()
	music.stop()
	deathSound.play()
	




