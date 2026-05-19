extends CharacterBody2D

@onready var 状态机 :Node = $"状态机"
var 状态:String = ""
var 速度 := 300.0

func _ready() -> void:
	状态机.set_physics_process(true)
	状态改变(预加载.状态待机)

func 状态改变(脚本:GDScript):
	if 状态机.has_method("结束时"):
		状态机.结束时()
	状态机.set_script(脚本)
	状态机.开始时()
	pass
