extends Node

var 面相的对象 : CharacterBody2D
var 动画 : AnimationPlayer

func 开始时():
	面相的对象= get_parent()
	动画 = 面相的对象.get_node("动画")
	动画.play("死亡")
	面相的对象.状态="死亡"
	print("当前状态是",面相的对象.状态)
