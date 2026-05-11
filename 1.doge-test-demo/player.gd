extends Area2D

signal hit

@export var speed=300

var screen_size

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size=get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var veloctiy=Vector2.ZERO
	if Input.is_action_pressed(&"move_left"):
		veloctiy.x-=1
	if Input.is_action_pressed(&"move_right"):
		veloctiy.x+=1
	if Input.is_action_pressed(&"move_up"):
		veloctiy.y-=1
	if Input.is_action_pressed(&"move_down"):
		veloctiy.y+=1
	
	if veloctiy.length()>0:
		veloctiy=veloctiy.normalized()*speed
		$AnimatedSprite2D.play()
	else :
		$AnimatedSprite2D.stop()
	
	position+=veloctiy*delta
	position=position.clamp(Vector2.ZERO,screen_size)
	
	if veloctiy.x!=0:
		$AnimatedSprite2D.animation=&"right"
		$AnimatedSprite2D.flip_v=false
		#$Trail.rotation=0
		rotation=0
		$AnimatedSprite2D.flip_h=veloctiy.x<0
	elif veloctiy.y!=0:
		$AnimatedSprite2D.animation=&"up"
		rotation=PI if veloctiy.y>0 else 0

func start(pos):
	position=pos
	rotation=0
	show()
	$CollisionShape2D.disabled=false

func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred(&"disabled",true)
