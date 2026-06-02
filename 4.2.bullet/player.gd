extends CharacterBody2D


const SPEED = 300.0

var look_direction := Vector2()


func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	if not direction:
		return
	look_direction=direction
	velocity = direction * SPEED
	move_and_slide()
