extends Timer

func _on_timeout() -> void:
	$"../角色".状态改变(预加载.状态死亡)
	
