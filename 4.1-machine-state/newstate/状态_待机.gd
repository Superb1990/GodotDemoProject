extends Node

var 面相的对象 : CharacterBody2D
var 动画 : AnimationPlayer

func 开始时():
	面相的对象= get_parent()
	动画 = 面相的对象.get_node("动画")
	动画.play("待机")
	面相的对象.状态="待机"
	print("当前状态是",面相的对象.状态)


func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("k"):
		面相的对象.状态改变(预加载.摇头晃脑)
		return
	var 方向 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if 方向:
		面相的对象.状态改变(预加载.状态移动)
		return

		
