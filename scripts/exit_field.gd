extends Area2D

signal bird_despawned


func _on_area_entered(area: Area2D):
	area.queue_free()
	emit_signal("bird_despawned")
