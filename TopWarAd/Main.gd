extends Node2D
var velocity = Vector2()

func merge():
	for soldier in get_node("Soldiers").get_children():
		for mergee in get_node("Soldiers").get_children():
			if(soldier != mergee and soldier.claimed and mergee.claimed):
				if(soldier.level == mergee.level):
					mergee.queue_free()
					soldier.level_up()		
func target():
	for soldier in get_node("Soldiers").get_children():
		soldier.set_target(get_global_mouse_position())	
		
func get_input():
		velocity = Vector2()
		if Input.is_action_pressed("Right"):
			velocity.x += 1
		if Input.is_action_pressed("Left"):
			velocity.x -= 1
		if Input.is_action_pressed("Down"):
			velocity.y += 1
		if Input.is_action_pressed("Up"):
			velocity.y -= 1
		for soldier in get_node("Soldiers").get_children():
			soldier.set_velocity(velocity)
		if Input.is_action_pressed("Merge"):
			merge()
		if(Input.is_action_just_pressed("Target")):
			target()

func _physics_process(delta):
	get_input()
	

