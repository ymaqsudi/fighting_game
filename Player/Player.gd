extends KinematicBody2D

export (PackedScene) var Bullet

onready var end_of_gun = $EndOfGun



var speed = 0
var max_speed = 200
var acceleration = 1000
var move_direction = Vector2(0,0)

func _physics_process(delta):
	MovementLoop(delta)
	
	
func _process(delta):
	pass
	
func MovementLoop(delta):
	move_direction.x = int(Input.is_action_pressed("Right")) - int(Input.is_action_pressed("Left"))
	move_direction.y = (int(Input.is_action_pressed("Down")) - int(Input.is_action_pressed("Up"))) / float(2)
	
	#look_at(get_global_mouse_position())
	
	if move_direction == Vector2(0,0):
		speed = 0
	else:
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
		var motion = move_direction.normalized() * speed
		move_and_slide(motion)
		


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("shoot"):
		shoot()
		
func shoot():
	var bullet_instance = Bullet.instance()
	owner.add_child(bullet_instance)
	bullet_instance.transform = end_of_gun.global_transform
