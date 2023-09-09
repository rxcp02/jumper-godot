extends KinematicBody2D

const SPEED = 128
const FLOOR = Vector2(0, -1)
const GRAVITY = 10
const JUMP_HEIGHT = 332
onready var motion : Vector2 = Vector2.ZERO
var can_move : bool

var health = 100
export var punish = 0.65

onready var jump = $jump

var playback : AnimationNodeStateMachinePlayback

func _ready():
	playback = $AnimationTree.get("parameters/playback")
	playback.start("idle")
	$AnimationTree.active = true	
	
func _process(_delta) :
	motion_ctrl()
	jump_ctrl()

func get_axis() -> Vector2:
	var axis = Vector2.ZERO
	axis.x = int(Input.is_action_pressed( "ui_right")) - int(Input.is_action_pressed("ui_left"))
	return axis
 
func motion_ctrl():
	motion.y += GRAVITY

	if can_move:
		motion.x = get_axis().x * SPEED
		
	if get_axis().x == 0:
		playback.travel("idle")
		health -= punish
		$Particles.emitting = false
		
	else:
		playback.travel("run")
		if is_on_floor():
			health += punish
			if health >= 100:
				health = 100
		$Particles.emitting = true
		
	if get_axis().x == 1:
		$AnimatedSprite.flip_h = true
	elif get_axis().x == -1:
		$AnimatedSprite.flip_h = false
			
	motion = move_and_slide(motion, FLOOR)
	
func jump_ctrl():
	match is_on_floor():
		true:
			can_move = true
			if Input.is_action_just_pressed("ui_up"):
				jump.play()
				motion.y -= JUMP_HEIGHT
				health -= punish
		
		false:
			if motion.y < 0:
				playback.travel("jump")
				$Particles.emitting = false
			else:	
				health -= punish
				playback.travel("fall")
				$Particles.emitting = false
				
func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		queue_free()


