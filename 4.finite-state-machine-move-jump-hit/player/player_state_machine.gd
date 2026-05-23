extends "res://state_machine/state_machine.gd"

#延迟获取状态节点引用
@onready var idle:Node = $Idle
@onready var move:Node= $Move
@onready var jump:Node=$Jump
@onready var stagger :Node = $Stagger
@onready var attack:Node = $Attack

#节点准备就绪时调用
func _ready() -> void:
	#初始化状态映射表
	states_map = {
		"idle":idle,
		"move":move,
		"jump":jump,
		"stagger":stagger,
		"attack":attack
	}
	

#改变状态的函数 （覆盖父类方法）
func _change_state(state_name:String) -> void:
	# 父类的 state_machine已经完成了大部分工作
	if not _active:#果状态机未激活
		return
	#特殊处理：将某些状态推入状态栈
	if state_name in ["stagger","jump","attack"]:
		states_stack.push_front(states_map[state_name])
  	#特殊处理 ：从移动状态切换到跳跃状态
	if state_name == "jump" and current_state ==move:
		#初始化跳跃状态，传递前移动速度和移动向量
		jump.initialize(move.speed,move.velocity)
	#调用父类的_chage_state 方法
	super._change_state(state_name)
	
# 未处理的输入事件
func _unhandled_input(event: InputEvent) -> void:
	#这里只处理可以终端状态的特殊键入（在本例中是 攻击）
	# 其他 输入由当前状态节点处理
	
	#检车攻击按键按下
	if event.is_action_pressed("attack"):
		#如果当前是攻击或者受击中台，忽略攻击输入
		if current_state in [attack,stagger]:
			return
		#切换到攻击状态
		_change_state("attack")
		return
	#将其他输入委托给当前状态处理
	current_state.handle_input(event)	
	
	
	
	
	
