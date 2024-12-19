extends CPUParticles2D


func _ready():
	global_position = get_viewport_rect().size / 2
	emission_rect_extents = get_viewport_rect().size
