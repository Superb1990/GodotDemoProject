extends "res://state_machine/state.gd"

#开始时
func enter()->void:
	owner.get_node(^"AnimationPlayer").play("stagger")

#动画播放完成时
func _on_animation_finished(anim_name: String) -> void:
	#断言检查，确保播放的动画是 受击
	assert(anim_name == "stagger")
	finished.emit("previous")
	
