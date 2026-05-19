extends Node


func 开始时():
	get_parent().modulate = Color(0.0, 0.0, 1.0, 1.0)
	

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		get_parent().状态改变(预加载.状态1)
	if Input.is_action_just_pressed("ui_right"):
		get_parent().状态改变(预加载.状态3)
