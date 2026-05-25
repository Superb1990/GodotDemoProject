extends CharacterBody2D
# 继承自 CharacterBody2D
# 玩家是一个 CharacterBody2D，换句话说是一个物理驱动的对象
# 它可以移动、与世界碰撞等等...
# 玩家有一个状态机，但身体和状态机是分离的

# 信号：方向改变时发出
signal direction_changed(new_direction:Vector2)

#视线方向变量
var look_direction := Vector2.RIGHT:
	#设置器，当 look_direction 被赋值时自动调用
	set(value):
		look_direction = value
		set_look_direction(value)

#收到伤害的函数
func take_damage(attacker:Node,amount:float,effect:Node=null) -> void:
	#如果攻击是自己的后代节点 （防止自伤）
	if is_ancestor_of(attacker):
		return
	
	#设置受击状态的击退方向（从攻击者向玩家的反方向）
	$States/Stagger.knockback_direction = (attacker.global_position-global_position).normalized()
	
	# 调用生命值组件的 收到伤害 函数
	$Health.take_damage(amount,effect)

#设置死亡状态的函数
func set_dead(value:bool) ->void:
	#根据是否死亡  启用/禁用 输入处理
	set_process_input(not value)
	#根据是否死亡  启用/禁用 物理输入
	set_physics_process(not value)
	#根据是否死亡  启用/禁用 碰撞多边形
	$CollisionPolygon2D.disabled = value

#设置视线方向的函数
func set_look_direction(value : Vector2) -> void:
	direction_changed.emit(value)
