extends Node2D

const BULLET_COUNT=500
const SPEED_MIN=20
const SPEED_MAX=80

const bullet_image:=preload("res://img/bullet.png")

var bullets:=[]
var shape:=RID()

class Bullet:
	var position:=Vector2()
	var speed:=1.0
	var body:=RID()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	shape=PhysicsServer2D.circle_shape_create()
	PhysicsServer2D.shape_set_data(shape,8)
	for i in BULLET_COUNT:
		var bullet:=Bullet.new()
		bullet.speed=randf_range(SPEED_MIN,SPEED_MAX)
		bullet.body=PhysicsServer2D.body_create()
		
		PhysicsServer2D.body_set_space(bullet.body,get_world_2d().get_space())
		PhysicsServer2D.body_add_shape(bullet.body,shape)
		PhysicsServer2D.body_set_collision_mask(bullet.body,0)
		var viewport_size=get_viewport_rect().size
		bullet.position=Vector2(
			randf_range(0,viewport_size.x)+viewport_size.x,randf_range(0,viewport_size.y)
		)
		var transform2d:=Transform2D()
		transform2d.origin=bullet.position
		#这里设置的是 刚体 的坐标（新创建的物体，设置刚体后，需要再设置刚体位置，即和该物体的坐标一样）
		PhysicsServer2D.body_set_state(bullet.body,PhysicsServer2D.BODY_STATE_TRANSFORM,transform2d)
		bullets.push_back(bullet)

func _process(delta: float) -> void:
	queue_redraw()

func _physics_process(delta: float) -> void:
	var transform2d:=Transform2D()
	var offset:=get_viewport_rect().size.x+16
	
	for bullet:Bullet in bullets:
		bullet.position.x-=bullet.speed*delta
		
		if bullet.position.x <-16:
			bullet.position.x=offset
		transform2d.origin=bullet.position
		PhysicsServer2D.body_set_state(bullet.body,PhysicsServer2D.BODY_STATE_TRANSFORM,transform2d)
	
func _draw()->void:
	var offset := -bullet_image.get_size()*0.5
	for bullet : Bullet in bullets:
		draw_texture(bullet_image,bullet.position+offset)

func _exit_tree() -> void:
	for bullet:Bullet in bullets:
		PhysicsServer2D.free_rid(bullet.body)
	
	PhysicsServer2D.free_rid(shape)
	bullets.clear()
