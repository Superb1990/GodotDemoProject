extends Node

@warning_ignore("unused_signal")
signal  finished(next_state_name:String)
# Called when the node enters the scene tree for the first time.

func enter()->void:
	pass
	
func exit()->void:
	pass
	
func handle_input(_event : InputEvent) -> void:
	pass

func update(_delta:float) -> void:
	pass

func _on_animation_finished(_anim_name: String) -> void:
	pass # Replace with function body.
