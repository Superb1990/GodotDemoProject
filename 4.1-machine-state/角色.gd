extends CharacterBody2D

@onready var 状态机 :Node = $"状态机"


func _ready() -> void:
	状态机.set_physics_process(true)
	状态改变(load("res://状态1.gd"))

func 状态改变(脚本:GDScript):
	状态机.set_script(脚本)
	状态机.开始时()
	pass
