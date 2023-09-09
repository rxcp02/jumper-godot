extends KinematicBody2D

var velocity: Vector2

func _ready():
	#init()
	pass
	
func init(speed = Vector2(100,100)):
	velocity = speed

func _physics_process(delta):
	var collision_info = move_and_collide(velocity*delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.normal)
