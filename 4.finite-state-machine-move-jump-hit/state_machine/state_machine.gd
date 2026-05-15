extends Node

#信号：状态改变时发出
signal state_changed(current_state:Node)

#你应从检查器或在继承此状态机接口的点上设置起始节点
#如果不设置，游戏将默认使用状态机子节点中的第一个状态
@export var start_state:NodePath

#状态映射表
var states_map:={}

#状态栈
var states_stack:=[]

#前状态
var current_state:Node= null

#活跃状态标志
var _active := false:
	set(value):
		_active = value
		#set_active(value)  #设置激活状态

#节点进入场景树时调用
func _enter_tree()-> void :
	# 如果起始状态未设置，使用第一个子节点
	if start_state.is_empty():
		start_state=get_child(0).get_path()
	
	#为所有子节点连接 finished信号
	for child in get_children():
		#var err:bool=child.finished.connect(_change_stete)
		#if err:
			#printerr(err)
		pass
	#初始化状态机
	initialize(start_state)

#初始化状态机
func initialize(initial_state:NodePath) -> void:
	_active = true  #设置为激活
	states_stack.push_front(get_node(initial_state)) # 将初始状态 压入 栈
	current_state = states_stack[0]  #设置当前状态
	current_state.enter()   # 调用进入状态方法

	
	
	
