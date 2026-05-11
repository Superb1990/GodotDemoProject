extends CharacterBody2D


const WALK_FORCE=600
const WALK_MAX_SPEED=200
const STOP_FORCE=1300
const JUMP_SPEED=200

@onready var gravity:float = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	var walk:=WALK_FORCE * (Input.get_axis(&"move_left",&"move_right"))
	#print("current walk: ",walk)
	if abs(walk)<WALK_FORCE*0.2:
		velocity.x= move_toward(velocity.x,0,STOP_FORCE*delta)
		#if walk==0.0:
			#return
		#print("enter walk<walk force * 0.2:")
		#print("walk:" ,walk)
		#
		#print("velocity.x : ",velocity.x)
		#print("stop_force * delta:",STOP_FORCE*delta)
	else :
		print("enter walk>=walk force * 0.2:")
		print("current velocity.x:",velocity.x)
		print("current walk*delta:",walk*delta)
		velocity.x+=walk*delta
		print("finish velocity.x:",velocity.x)
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)
	velocity.y+=gravity*delta
	move_and_slide()
	
	if is_on_floor()&&Input.is_action_just_pressed("jump"):
	#if Input.is_action_just_pressed("jump"):
		print("enter jump:")
		print("jumpforce:",JUMP_SPEED)
		velocity.y=-JUMP_SPEED
		
		
