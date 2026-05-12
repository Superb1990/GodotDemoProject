extends Area2D

#信号  攻击完成
signal attack_finished

#定义状态
enum States{
	IDLE,    # 空闲状态
	ATTACK   # 攻击状态
}

#攻击状态
enum AttackInputStates{
	IDLE,       #空闲状态
	LISTENING,  #监听输入
	REGISTERED  #攻击输入已注册
}

#当前状态
var state:States = States.IDLE
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
var combo := [{
	"damage" : 1,
	"animation" : "attack_fast",
	"effect" : null
},{
	"damage" : 1,
	"animation" : "attack_fast",
	"effect" : null
},{
	"damage" : 3,
	"animation" : "attack_medium",
	"effect" : null
},]

#已攻击目标集合（防止重复攻击）
var hit_objects := []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
