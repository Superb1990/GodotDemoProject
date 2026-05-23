extends CharacterBody2D
# 继承自 CharacterBody2D
# 玩家是一个 CharacterBody2D，换句话说是一个物理驱动的对象
# 它可以移动、与世界碰撞等等...
# 玩家有一个状态机，但身体和状态机是分离的

# 信号：方向改变时发出
signal direction_changed(new_direction:Vector2)

#视线方向变量
var look_direction := Vector2.RIGHT:
	#设置器，当 look_direction 被复制时自动调用
	set(value):
		look_direction = value

#收到伤害的函数
func take_damage(attacker:Node,amount:float,effect:Node=null) -> void:
	#如果攻击是自己的后代节点 （防止自伤）
	if is_ancestor_of(attacker):
		return
	
