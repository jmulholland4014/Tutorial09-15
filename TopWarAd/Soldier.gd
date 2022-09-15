extends KinematicBody2D

export (int) var speed = 200
export (bool) var claimed = false
export (String) var player = null
export (int) var level = 1
var velocity = Vector2()
var bullet = preload("res://Bullet.tscn")
var target = null
export (int) var bullet_speed = 1000
export(float) var fire_rate = .2
var can_fire = true

func handle_collisions():
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		var collider = collision.collider
		if(collider.claimed == true):
			claimed = true
			player = collider.player
			target = collider.target
			
func _physics_process(delta):
	velocity = move_and_slide(velocity)
	handle_collisions()
	print('Hello World')

func set_velocity(v):
	if(claimed):
		velocity = v.normalized() * speed*2

func level_up():
	level+=1
	fire_rate *=.5
	get_node("Level").text = str(level)

func _process(delta):
	if(target != null and claimed and can_fire):
		look_at(target)
		var bullet_instance = bullet.instance()
		bullet_instance.position = get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
		get_tree().get_root().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(fire_rate), "timeout")
		can_fire = true

func set_target(t):
	target = t
	
