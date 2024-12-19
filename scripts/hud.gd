extends Control

signal restart_game

@export var exit_field: Area2D
@onready var label: Label = $Label
@onready var death_screen: VBoxContainer = $Deathscreen
var score = 0


func _ready():
	assert(exit_field)
	death_screen.hide()
	size = get_viewport_rect().size
	exit_field.connect("bird_despawned", update_score)


func update_score():
	score += 1
	label.text = "Score: " + str(score)


func _on_game_player_died():
	death_screen.show()


func _on_restart_button_up():
	emit_signal("restart_game")
	score = -1
	update_score()
	death_screen.hide()


func _on_quit_button_up():
	get_tree().quit()
