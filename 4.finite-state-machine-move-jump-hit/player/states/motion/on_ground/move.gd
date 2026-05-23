extends "on_ground.gd"

#最大行走速度
@export var max_walk_speed:= 450.0

#最大奔跑速度
@export var max_run_speed := 700.0

#开始时函数
func enter()->void:
	#初始化速度和速度向量
	speed = 0.0
	velocity = Vector2()
	
	#获取输入方向
	var input_direction := get_input_direction()
	#更新面向方向
	update_look_direction(input_direction)
	#播放行走动画
	owner.get_node(^"AnimationPlayer").play("walk")
	
#处理输入事件
func handle_input(event : InputEvent) -> void:
	return super.handle_input(event)

#状态更新数 _physics_process函数已委托给update
func update(_delta:float) -> void:
	#获取当前输入方向
	var input_direction := get_input_direction()
	#如果没有输入（方向近似为零向量）
	if input_direction.is_zero_approx():
		#发射信号，示状态完成，切换到idle状态  
		#在statemachine脚本中已将所有子节点finished信号注册到 changestate函数中
		#所有状态节点都继承 state脚本，state脚本中定义有  finished信号
		#所有状态均为statemachine的子节点，而statemahine的脚本player_state_machine继承 statemahine脚本
		finished.emit("idle")
	#更新面向方向
	update_look_direction(input_direction)
	
	#监测是否按下奔跑键
	if Input.is_action_pressed("run"):
		#使用奔跑速度
		speed = max_run_speed
	else :
		#使用行走速度
		speed = max_walk_speed
	#移动并获取碰撞信息
	var collision_info := move(speed,input_direction)
	#如果没有碰撞则直接返回
	if not collision_info:
		return
	#如果是奔跑状态 且 碰撞物体是环境物体 则通过（不碰撞）
	if speed == max_run_speed and collision_info.collider.is_in_ground("enviroment"):
		return

#移动函数
func move(p_speed:float,direction:Vector2) ->KinematicCollision2D:
	#设置拥有者的速度向量
	owner.velocity = direction.normalized() * p_speed
	#执行移动
	owner.move_and_slide()
	#如果没有碰撞，则返回空
	if owner.get_slide_collision_count() == 0 :
		return null 
	#返回第一个碰撞到的物体信息
	return owner.get_slide_collision(0)
