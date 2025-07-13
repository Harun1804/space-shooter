extends Node2D

@onready var startButton = $CanvasLayer/CenterContainer/Start
@onready var gameOver = $CanvasLayer/CenterContainer/GameOver

var enemy = preload("res://scenes/enemy.tscn")
var score = 0

func _ready():
	startButton.show()
	gameOver.hide()

func spawn_enemies():
	for x in range(9):
		for y in range(3):
			var e = enemy.instantiate()
			var pos = Vector2(x * (16 + 8) + 24, 16 * 4 + y * 16)
			add_child(e)
			e.start(pos)
			e.died.connect(_on_enemy_died)

func _on_enemy_died(value):
	score += value
	$CanvasLayer/UI.updateScore(score)

func _on_start_pressed() -> void:
	startButton.hide()
	newGame()

func newGame():
	score = 0
	$CanvasLayer/UI.updateScore(score)
	$Player.start()
	$Player.show()
	spawn_enemies()


func _on_player_died() -> void:
	get_tree().call_group("enemies", "queue_free")
	gameOver.show()
	await get_tree().create_timer(2).timeout
	gameOver.hide()
	startButton.show()
