extends CharacterBody2D

@export var JUMP_VELOCITY = -400.0
@onready var particle_emitor: Marker2D = $ParticleEmitor
var propell_particles = preload("res://scenes/player_propell_particles.tscn")


func _physics_process(delta):
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump"):
		spawn_particles()
		velocity.y = JUMP_VELOCITY

	move_and_slide()

func spawn_particles() -> void:
	var particles: CPUParticles2D = propell_particles.instantiate() as CPUParticles2D
	particle_emitor.add_child(particles)
	particle_emitor.global_position = particle_emitor.global_position
