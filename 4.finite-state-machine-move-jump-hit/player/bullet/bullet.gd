extends CharacterBody2D

var direction := Vector2()
@export var speed := 1000.0

@export var root := get_tree().root

func _ready() -> void:
	set_as_top_level(true)

func _physics_process(delta: float) -> void:
	pass
