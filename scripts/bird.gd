extends Area2D

@export var speed: int = 200


func _ready():
	$AnimatedSprite2D.frame = randi_range(0, 7)
	$AnimatedSprite2D.play("default")


func _process(delta):
	global_position.x -= speed * delta


func _on_body_entered(body: CharacterBody2D):
	if body.is_in_group("player"):
		$CPUParticles2D.emitting = true
