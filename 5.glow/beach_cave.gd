extends Node2D

const CAVE_LIMIT = 1000

var glow_map := preload("res://glow_map.webp")

@onready var cave : Node2D = $Cave
@onready var worldenv: WorldEnvironment =$WorldEnvironment



func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and event.button_mask > 0:
		cave.position.x = clampf(cave.position.x + event.relative.x, -CAVE_LIMIT, 0)
		
	if event.is_action_pressed("toggle_glow_map"):
		if worldenv.environment.glow_map:
			worldenv.environment.glow_map = null
			worldenv.environment.glow_hdr_threshold=1.0
			worldenv.environment.glow_intensity = 0.8
			worldenv.environment.glow_hdr_threshold = 1.0
			worldenv.environment.glow_strength = 1.0
			worldenv.environment.glow_blend_mode =Environment.GLOW_BLEND_MODE_ADDITIVE
			#worldenv.environment.glow_blur_passes=3
			#worldenv.environment.glow_blend_mode =Environment.GLOW_BLEND_MODE_ADDITIVE
		else :
			worldenv.environment.glow_map=glow_map
			worldenv.environment.glow_intensity = 1.6
			worldenv.environment.glow_hdr_threshold=0.6
			worldenv.environment.glow_hdr_threshold = 0.6
			worldenv.environment.glow_strength = 1.2
			worldenv.environment.glow_blend_mode =Environment.GLOW_BLEND_MODE_SCREEN
			#worldenv.environment.glow_blur_passes=4
			
