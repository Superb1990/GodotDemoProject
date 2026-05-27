extends Panel

@onready var fsm_node : Node = get_node(^"../../player/StateMachine")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var states_names := ""
	var numbers := ""
	var index := 0
	if !fsm_node or fsm_node.states_stack==null:
		return
	for state : Node in fsm_node.states_stack:
		states_names += String(state.name)+ "\n"
		numbers += str(index) + "\n"
		index +=1 
	
	%States.text = states_names
	%Numbers.text = numbers
