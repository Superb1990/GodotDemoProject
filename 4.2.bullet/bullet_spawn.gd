extends Node2D


var bullet := preload("res://bullet/Bullet.tscn")


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("k"):
		fire()
		
# 射击
func fire():
	# 射击间隔 使用 timer来限制
	if not $CoolDownTimer.is_stopped():
		return
	
	$CoolDownTimer.start()
	# 实例化子弹
	var newbullet := bullet.instantiate()
	add_child(newbullet)
	
	# 确定子弹的出生点和发射方向
	newbullet.position = global_position
	newbullet.direction = owner.look_direction
