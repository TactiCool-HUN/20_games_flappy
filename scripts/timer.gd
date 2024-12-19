extends Timer


func _on_timeout2():
	if wait_time > 0.4:
		wait_time = wait_time * 0.95
	else:
		Engine.time_scale += 0.001
