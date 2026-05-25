extends CharacterBody2D

#移动方向
var direction := Vector2()

#速度
@export var speed := 1000.0

#获取场景根节点
@onready var root := get_tree().root

#节点就绪时调用
func _ready() -> void:
	#设置为顶层节点(不受父节点变换影响)
	set_as_top_level(true)

#物理处理过程
func _physics_process(delta: float) -> void:
	#检查点否离开屏幕可见区域
	if not root.get_visible_rect().has_point(position):
		queue_free()
	#计算移动量
	var motion := direction * speed * delta
	#移动并检测碰撞
	var collision_info := move_and_collide(motion)
	#如果发生碰撞
	if collision_info : 
		queue_free()

func _draw()->void:
	#绘制一个圆形（用于调试或可视化）
	#位置 ： Vector2() 表示本地坐标原点
	draw_circle(Vector2(),$CollisionShape2D.shape.radius,Color.WHITE)
