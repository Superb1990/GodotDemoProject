extends Label

var start_postion :=Vector2()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_postion = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	position =$"../BodyPivot".position + start_postion

func _on_StateMachine_state_changed(current_state:Node)->void:
	text = String(current_state.name)
