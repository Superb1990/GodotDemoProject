extends Node

var 面相的对象 : CharacterBody2D
var 动画 : AnimationPlayer

func 开始时():
	面相的对象= get_parent()
	面相的对象.状态="摇头晃脑"
	动画 = 面相的对象.get_node("动画")
	动画.play("摇头晃脑")
	print("当前状态是",面相的对象.状态)

func _physics_process(delta: float) -> void:
	if 动画.current_animation=="":
		面相的对象.状态改变(预加载.状态待机)
		return
