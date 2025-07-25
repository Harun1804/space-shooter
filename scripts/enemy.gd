extends Area2D

signal died
var startPos = Vector2.ZERO
var speed = 0
var bulletScene = preload("res://scenes/enemy_bullet.tscn")

@onready var screenSize = get_viewport_rect().size

func start(pos):
	speed = 0
	position = Vector2(pos.x, -pos.y)
	startPos = pos
	await get_tree().create_timer(randf_range(0.25, 0.55)).timeout
	var tween = create_tween().set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "position:y", startPos.y, 1.4)
	await tween.finished
	$MoveTimer.wait_time = randf_range(5, 20)
	$MoveTimer.start()
	$ShootTimer.wait_time = randf_range(4, 20)
	$ShootTimer.start()

func _on_move_timer_timeout() -> void:
	speed = randf_range(75, 100)

func _on_shoot_timer_timeout() -> void:
	var b = bulletScene.instantiate()
	get_tree().root.add_child(b)
	b.start(position)
	$ShootTimer.wait_time = randf_range(4, 20)
	$ShootTimer.start()

func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > screenSize.y + 32:
		start(startPos)

func explode():
	speed = 0
	$AnimationPlayer.play("explode")
	set_deferred("monitoring", false)
	died.emit(5)
	await $AnimationPlayer.animation_finished
	queue_free()
	
