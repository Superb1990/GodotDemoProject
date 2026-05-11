extends TileMapLayer


var player_in_secret:=false
var layer_alpha:=1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_process(false)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player_in_secret:
		if layer_alpha>0.3:
			layer_alpha=move_toward(layer_alpha,0.3,delta)
			self_modulate=Color(1,1,1,layer_alpha)
		else :
			set_process(false)
	else :
		if layer_alpha<1.0:
			layer_alpha=move_toward(layer_alpha,1.0,delta)
			self_modulate=Color(1,1,1,layer_alpha)
		else :
			set_process(false)

func _use_tile_data_runtime_update(coords: Vector2i) -> bool:
	return true
	
	
func _tile_data_runtime_update(coords: Vector2i, tile_data: TileData) -> void:
	tile_data.set_collision_polygons_count(0,0)	


func _on_secret_detector_body_entered(body: Node2D) -> void:
	if body is not CharacterBody2D:
		return
	player_in_secret=true
	set_process(true)


func _on_secret_detector_body_exited(body: Node2D) -> void:
	if body is not CharacterBody2D:
		return
	player_in_secret = false
	set_process(true)
