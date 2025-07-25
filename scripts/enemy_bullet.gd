extends Area2D

@export var speed = 150

func start(pos):
	position = pos

func _process(delta: float) -> void:
	position.y += speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		queue_free()
		area.shield -= 1
