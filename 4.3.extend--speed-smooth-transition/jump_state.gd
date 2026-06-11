extends Node

var isactive : =false

#基础最大  水平速度
@export var base_max_horizontal_speed := 400.0
#空中控制参数
@export var air_acceleration := 1000.0  #空中加速度
@export var air_deceleration := 2000.0	#空中减速度
@export var air_steering_power :=50.0	#空中转向力

#重力
@export var gravity := 1600.0

#进入状态时的 速度
var enter_velocity := Vector2()

#水平移动相关变量
var max_horizontal_speed := 0.0 	 #最大水平速度
var horizontal_speed := 0.0			 #当前水平速度
var horizontal_velocity := Vector2() #水平速度向量
#垂直移动相关变量
var vertical_speed := 0.0  #垂直速度
var height := 0.0		   #跳跃高度


#初始化函数
func initialize(speed:float,velocity:Vector2) ->void:
	#设置水平速度
	horizontal_speed = speed
	#print("jump init")
	#如果传入速度大于0 ， 则使用传入速度作为最大速度
	if speed >0:
		max_horizontal_speed = speed
	else :
		# 否则使用基础最大速度
		max_horizontal_speed = base_max_horizontal_speed
	
	#保存进入状态时的速度
	enter_velocity = velocity
	enter()

# Called when the node enters the scene tree for the first time.
func enter() -> void:
	#获取输入方向
	var input_direction := get_input_direction()
	#更新面向方向
	update_look_direction(input_direction)
	
	#如果有输入方向
	if input_direction:
		#水平速度初始化为进入状态时的速度
		horizontal_velocity = enter_velocity
	else :
		#否则重置为0
		horizontal_velocity = Vector2()
	#设置初始化垂直速度 （向上跳跃）
	vertical_speed = 600.0
	isactive = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !isactive:
		return
	#获取输入方向
	var input_direction := get_input_direction()
	#更新面向方向
	update_look_direction(input_direction)
	
	#水平移动
	move_horizontally(delta,input_direction)
	#计算跳跃高度动画
	animate_jump_height(delta)
	
	#如果高度 <=0 (落地)
	if height <=0.0:
		isactive=false
		

#水平移动函数	
func move_horizontally(delta:float,direction:Vector2) -> void:
	print("--------------------------------------------------")
	print("ori _ horizontal_speed : ",horizontal_speed ,"  air_acceleration : ",air_acceleration,"  delta :",delta, " air_acceleration * delta:",air_acceleration * delta)

	#根据是否有方向输入计算水平速度
	if direction:
		#有方向输入 ： 加速
		horizontal_speed += air_acceleration * delta
		
		print("horizontal_speed += air_acceleration * delta")
	else:
		#无方向输入  ： 减速
		horizontal_speed -= air_deceleration * delta
		
		print("horizontal_speed -= air_acceleration * delta")
		
	print("math _ horizontal_speed : ",horizontal_speed )
	
	#限制水平速度在 0 到 最大速度 之间
	horizontal_speed = clamp(horizontal_speed,0,max_horizontal_speed)
	
	print("clamp _ horizontal_speed : ",horizontal_speed ," direction :",direction )
	
	#计算目标速度向量
	var target_velocity := horizontal_speed * direction.normalized()
	
	print("target_velocity : ",target_velocity ,"  horizontal_velocity:" ,horizontal_velocity)
	print("target_velocity- horizontal_velocity : ",(target_velocity- horizontal_velocity) ,"(target_velocity- horizontal_velocity).normalized() :",((target_velocity- horizontal_velocity).normalized()) )
	
	#计算转向速度（从当前速度向目标速度平滑过渡）
	var steering_velocity := (target_velocity- horizontal_velocity).normalized()*air_steering_power
	
	print("steering_velocity：" , steering_velocity)
	
	#应用转向速度
	horizontal_velocity += steering_velocity
	
	print("horizontal_velocity += steering_velocity  end : horizontal_velocity :",horizontal_velocity)
	
	#应用速度到拥有者节点
	owner.velocity = horizontal_velocity
	#执行移动
	owner.move_and_slide()
	print("--------------------------------------------------")
#跳跃高度动画函数
func animate_jump_height(delta:float) -> void:
	#print("ori---vertical_speed:",vertical_speed)
	#应用重力（减少垂直速度）
	vertical_speed -= gravity * delta
	#print("end---vertical_speed:",vertical_speed)
	#更新高度
	height += vertical_speed * delta
	#print("height:",height)
	#确保高度不低于0
	height = max(0.0,height)
	#更新身体枢轴点的y位置（模拟跳跃高度变化）
	owner.get_node(^"BodyPivot").position.y = -height
	

func get_input_direction()-> Vector2:
	return Vector2(
		Input.get_axis("ui_left","ui_right"),
		Input.get_axis("ui_up","ui_down")
	)

func update_look_direction(direction:Vector2)->void:
	if direction and owner.look_direction != direction:
		owner.look_direction = direction
