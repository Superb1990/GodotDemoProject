extends Node2D

#导出变量：球的场景资源，可在编辑器中替换
@export var ball_scence : PackedScene = preload("res://ball.tscn")

#处理未被其他节点处理的输入事件
func _unhandled_input(event: InputEvent) -> void:
	#如果事件是重复触发的（比如按住案件不放产生的连续事件）
	if event.is_echo():
		return  # 忽略重复事件
		
	#如果是鼠标事件，并且是按下状态（不是抬起）
	if event is InputEventMouseButton and event.is_pressed():
		#如果鼠标左键
		if event.button_index == MOUSE_BUTTON_LEFT:
			#获取鼠标的全局位置，并在该位置生成球
			spawn(get_global_mouse_position())

#在指定位置生成球的函数
func spawn(spawn_global_postion:Vector2) :
	# 从预加载的场景模版创建球的一个实例
	var instance : Node2D = ball_scence.instantiate()
	# 将实例的全局位置设置为传入的坐标
	instance.global_position = spawn_global_postion
	# 将实例添加到场景树中，成为当前节点的子节点
	add_child(instance)
