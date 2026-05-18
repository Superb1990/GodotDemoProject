extends Node


func 开始时():
	get_parent().modulate = Color(1.0, 0.0, 0.0, 1.0)
	pass

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_left"):
		get_parent().modulate = Color(0.0, 1.0, 0.0, 1.0)
		print("press left")
