extends "res://state_machine/state.gd"

func handle_input(event : InputEvent) -> void:
	if event.is_action_pressed("simulate_damage"):
		finished.emit("stagger")
		
		
func get_input_direction()-> Vector2:
	return Vector2(
		Input.get_axis("ui_left","ui_right"),
		Input.get_axis("ui_up","ui_down")
	)

func update_look_direction(direction:Vector2)->void:
	if direction and owner.look_direction != direction:
		owner.look_direction = direction
