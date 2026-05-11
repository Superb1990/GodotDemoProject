extends Node2D

#将敌人对象导出到 检查器（属性面板） 进行赋值
@export var mob_scene:PackedScene
var score

func game_over() -> void:
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	

func new_game() -> void:
	get_tree().call_group(&"mobs",&"queue_free")
	score=0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Music.play()




func _on_mob_timer_timeout() -> void:
	#实例化敌人
	var mob=mob_scene.instantiate()
	#获取敌人生成的路径
	var mob_spawn_location=$MobPath/MobSpawnLocation
	#设置敌人随机生成路径点
	mob_spawn_location.progress=randi()
	mob.position=mob_spawn_location.position
	#生成 一个 旋转方向（垂直于当前路径方向）
	var direction=mob_spawn_location.rotation+PI/2
	# 在基础旋转方向上，加上 随机偏移量 -45度~45度
	direction+=randf_range(-PI/4,PI/4)
	mob.rotation=direction
	#设置 初始速度为 150-250 沿x轴 正方向
	var veloctiy=Vector2(randf_range(150.0,250.0),0.0)
	# 将 速度向量旋转到敌人面对的方向
	mob.linear_velocity=veloctiy.rotated(direction)
	add_child(mob)

func _on_score_timer_timeout() -> void:
	score+=1
	$HUD.update_score(score)


func _on_start_timer_timeout() -> void:
	$MobTimer.start()
	$ScoreTimer.start()
