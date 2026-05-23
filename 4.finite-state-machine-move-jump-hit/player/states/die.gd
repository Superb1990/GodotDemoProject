extends "res://state_machine/state.gd"

func enter()->void:
	owner.set_dead(true)
	owner.get_node(^"AnimationPlayer").play("die")
	
func _on_animation_finished(anim_name: String) -> void:
	finished.emit("dead")
