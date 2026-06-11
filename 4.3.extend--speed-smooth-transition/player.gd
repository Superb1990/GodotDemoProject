extends CharacterBody2D

@onready var jumpstate : Node =$JumpState

const SPEED = 300.0
var look_direction := Vector2.RIGHT
var current_direction :=Vector2.ZERO

var moveIndex= 1


#物理每帧运行函数
func _physics_process(delta: float) -> void:
	current_direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	#print(current_direction)
	if jumpstate.isactive: #如果处于跳跃状态 则 返回
		return
	elif Input.is_action_just_pressed("jump") and !jumpstate.isactive:  #如果按下跳跃按钮，则进入跳跃状态
		jumpstate.initialize(SPEED,velocity)
		#jumpstate.enter()
	elif current_direction == Vector2.ZERO:   #如果没有按下任何按键 则 返回
		return
	elif  !jumpstate.isactive:  #如果上面都未触发， 且 没有进入跳跃状态  则进行移动
		move()
	

	
#简单移动
func move():
	if current_direction!=look_direction:
		look_direction=current_direction
	velocity = current_direction * SPEED
	move_and_slide()
	
	#测试移动发生在哪
	test_move_achor()

#测试移动发生在哪
func test_move_achor():
	print("Move 移动",moveIndex)
	moveIndex+=1
