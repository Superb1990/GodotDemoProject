extends Area2D

#信号  攻击完成
signal attack_finished

#定义状态
enum States {
	IDLE, # 空闲状态
	ATTACK # 攻击状态
}

#攻击状态
enum AttackInputStates {
	IDLE, # 空闲状态
	LISTENING, # 监听输入
	REGISTERED # 攻击输入已注册
}

#当前状态
var state: States = States.IDLE
#输入攻击状态
var attack_input_state := AttackInputStates.IDLE
#是否准备下一次攻击
var ready_for_next_attack := false
#最大连击数
const MAX_COMBO_COUNT = 3
#当前连击数
var combo_count := 0

#当前攻击数据
var attack_current := {}

#连击组合数据
var combo := [ {
	"damage": 1,
	"animation": "attack_fast",
	"effect": null
}, {
	"damage": 1,
	"animation": "attack_fast",
	"effect": null
}, {
	"damage": 3,
	"animation": "attack_medium",
	"effect": null
}, ]

#已攻击目标集合（防止重复攻击）
var hit_objects := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#连接  动画播放器 动画完成时 的  信号
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)
	#连接 区域进入 信号
	body_entered.connect(_on_body_entered)
	#初始化状态为空闲
	_change_state(States.IDLE)


func _change_state(new_state: States) -> void:
	#退出当前状态时的处理
	match state:
		States.ATTACK:
			hit_objects = [] # 清空命中列表
			attack_input_state = AttackInputStates.LISTENING # 重置为监听状态
			ready_for_next_attack = false # 重置 准备状态
	#进入新状态时的处理
	match new_state:
		States.IDLE: # 空闲
			combo_count = 0 # 重置连击计数
			$AnimationPlayer.stop() # 停止动画
			visible = false # 隐藏节点
			monitoring = false # 禁用碰撞监测
		States.ATTACK: # 攻击
			attack_current = combo[combo_count - 1] # 设置当前攻击数据
			$AnimationPlayer.play(attack_current["animation"]) # 播放攻击动画
			visible = true # 显示节点
			monitoring = true # 启用碰撞监测
	# 更新当前状态
	state = new_state

# 未处理输入事件
func _unhandled_input(event: InputEvent) -> void:
	#只有在攻击状态下处理
	if state != States.ATTACK:
		return
	#只有在监听输入状态下处理
	if attack_input_state != AttackInputStates.LISTENING:
		return
	#监测攻击键按下
	if event.is_action_pressed("attack"):
		attack_input_state = AttackInputStates.REGISTERED # 标记输入已注册

# 物理处理过程
func _physics_process(delta: float) -> void:
	if attack_input_state == AttackInputStates.REGISTERED and ready_for_next_attack:
		attack() # 攻击
		pass

#攻击函数
func attack() -> void:
	combo_count += 1 # 增加连击计数
	_change_state(States.ATTACK) # 切换到攻击状态


#设置攻击输入监听（供动画播放器调用）
func set_attack_input_listening()->void:
	attack_input_state = AttackInputStates.LISTENING

#设置准备好下一次攻击（供动画播放器调用）
func set_ready_for_next_attack()->void:
	ready_for_next_attack=true
	
#当有物体进入区域时
func _on_body_entered(body: Node2D) -> void:
	# 检查物体是否有生命值组件
	if not body.has_node("Health"):
		return
	#检查是否已命中过(防止重复命中)
	if body.get_rid().get_id() in hit_objects:
		return
	
	# 添加到已命中列表
	hit_objects.append(body.get_rid().get_id())
	
	#对物体造成伤害
	body.take_damage(self,attack_current["damage"],attack_current["effect"])

# 动画播放完成时
func _on_animation_finished(_name: String) -> void:
	if attack_current.is_empty():
		return
	#如果输入已注册且未达到最大连击数
	if attack_input_state==AttackInputStates.REGISTERED and combo_count < MAX_COMBO_COUNT:
		attack() #继续连击
	else :
		_change_state(States.IDLE) #返回空闲状态
		attack_finished.emit() # 发射攻击完成信号

# 当状态机 状态 改变时
func _on_StateMachine_state_changed(current_state:Node) -> void:
	if current_state.name=="Attack":
		attack()

	
