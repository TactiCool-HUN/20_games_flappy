extends Node2D

signal player_died

@export var bird_spawner: Marker2D
@onready var player: CharacterBody2D = $World/Player
var bird = preload("res://scenes/bird.tscn")
var play_death_anim: bool = false
var starting_position: Vector2


func _ready():
	assert(bird_spawner)
	starting_position = Vector2(get_viewport_rect().size.x * 0.1, get_viewport_rect().size.y * 0.5)
	bird_spawner.global_position = Vector2(get_viewport_rect().size.x + 50, 0)

	var zones = get_tree().get_nodes_in_group("death_zone") as Array[Area2D]
	for zone in zones:
		zone.connect("body_entered", player_death_zone)

	player.global_position = starting_position
	spawn_bird()


func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


func _physics_process(_delta):
	if play_death_anim:
		Engine.time_scale = Engine.time_scale * 0.9
		if Engine.time_scale < 0.01:
			emit_signal("player_died")
			play_death_anim = false
			Engine.time_scale = 0


func player_death_zone(_body: Node2D) -> void:
	play_death_anim = true


func _on_timer():
	spawn_bird()


func spawn_bird(spawn_amount: int = 1) -> void:
	for _i in range(spawn_amount):
		var birdie = bird.instantiate() as Area2D
		birdie.scale = birdie.scale * randf_range(0.8, 1.2)
		birdie.connect("body_entered", player_death_zone)
		bird_spawner.add_child(birdie)
		birdie.global_position = bird_spawner.global_position + Vector2(0, get_viewport_rect().size.y * randf_range(0, 1))


func _on_hud_restart_game():
	for child in bird_spawner.get_children():
		child.queue_free()
	spawn_bird()
	player.global_position = starting_position
	$Timer.wait_time = 0.8
	$Timer2.wait_time = 0.9
	Engine.time_scale = 1
